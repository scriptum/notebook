if hash ffmpeg 2>/dev/null; then # ffmpeg
  # get audio streams from a movie file
  ffaudio() {
    local file
    for file in "$@"; do
      echo "$file:"
      ffprobe -v error \
      -print_format csv \
      -select_streams a \
      -show_entries stream=index:stream_tags \
      "$file" \
      2> /dev/null
    done
  }

  # mix audio/video from different sources and normalize bass channel (useful for movies)
  ffmpeg.mix() {
    if [[ $# -lt 4 ]]; then
      echo "Usage: VIDEO_SRC AUDIO_SRC:AUDIO_STREAM OUTPUT BITRATE"
      return -1
    fi
    local audio_stream=${2##*:}
    local audio_src=${2%:*}
    local audio_codec="-c:a copy"
    [[ $4 != copy ]] && audio_codec="-c:a libopus -b:a ${4%k}k"
    ffmpeg -i "$1" -i "$audio_src" -c:v copy $audio_codec \
    -map 0:0 -map 1:$audio_stream -ac 2 -af \
    'asplit=2[b][t];
                [b]bandpass=100,dynaudnorm=10:3:0.25:m=3[b_norm];
                [t]bandreject=100,dynaudnorm=50:15:0.25:m=3[t_norm];
    [b_norm][t_norm]amix,volume=4' \
    -shortest $5 "$3"
  }

  # mix and apply audio normalization
  ffmpeg.mix.norm() {
    if [[ $# -lt 3 ]]; then
      echo "Usage: VIDEO_SRC AUDIO_STREAM BITRATE"
      return -1
    fi
    ffmpeg.mix "${1%.mkv}_1.mkv" "$1:$2" "${1%.mkv}_2.mkv" "$3" '-af dynaudnorm'
  }

  # helper function for audio files
  _find_audio()
  {
    find -type f -print0 | xargs -0 -n8 -P$(nproc) file -F/ | grep -i '/[^/]*audio' | sed 's@/[^/]*$@@'
  }
  # parallel convert all audio to ogg
  # WARNING! May overwrite and damage your files
  toogg() {
    _find_audio | xargs -d"\n" -n1 -P$(nproc) sh -c 'echo "$0"
      T=$(mktemp ./XXXX.ogg)
      ffmpeg -v quiet -y -i "$0" -vn -acodec libvorbis -ab 96k "$T"
      mv "$T" "${0%.*}.ogg"'
  }

  # parallel convert all audio to mp3
  # WARNING! May overwrite and damage your files
  tomp3() {
    _find_audio | xargs -d"\n" -n1 -P$(nproc) \
    sh -c 'echo "$0"
            _TMP=$(mktemp ./XXXX.mp3)
            ffmpeg -v quiet -y -i "$0" -vn -q:a 1 "$_TMP"
    mv "$_TMP" "${0%.*}.mp3"'
  }

  # - split audio on 5 minute files
  split_mp3() {
    _find_files_helper "*.mp3" "$@" | xargs -0 -P$(nproc) -I{} \
    sh -c '_f="{}"
            ffmpeg -i "$_f" -vn -c:a copy -f segment \
    -segment_time 5:00 "${_f%.mp3}"-%2d.mp3'
  }

  # normalize bass and treble separately (improve very old music or movies overloaded with bass)
  ffplay.bass()
  {
    ffplay "$@" -af -af 'asplit=2[b][t];
            [b]bandpass=100,dynaudnorm=10:3:0.25:m=3[b_norm];
            [t]bandreject=100,dynaudnorm=50:15:0.25:m=3[t_norm];
    [b_norm][t_norm]amix,volume=4'
  }

  # play a file with strong audio compression to listen it in a noisy environment
  ffplay.norm()
  {
    ffplay "$@" -af 'dynaudnorm=100:15:0.99:s=3'
  }
  # - split audio book on 5 minute files
  # - normalize audio volume
  # - remove silence
  # pass disable_normalization as first argument to disable normalization
  ffmpeg.audiobook()
  {
    if [[ $1 == --help ]]; then
      echo 'ffmpeg.audiobook [disable_normalization] [atempo=1.0] [segment_time=5:00] [filter=...] [play 01.mp3]'
      return
    fi
    # filters
    local gain=-4
    local norm=treble=g=$gain,bass=g=$gain
    local normalize=$norm,dynaudnorm=10:5:0.99:s=3,
    # do not use -ac 1 because it may cause clipping
    local mono="pan=mono|c0=.5*c0+.5*c1,"
    local silenceremove=silenceremove=1:0.1:0.01:-1:0.5:0.01:1
    local atempo=
    local segment="-f segment -segment_time 5:00"
    local filter_add=""
    while :; do
      case $1 in
        disable_normalization) normalize="" ;;
        soft) normalize="$norm,dynaudnorm=15:15:0.99," ;;
        atempo=*) atempo="$1," ;;
        segment_time=*) segment="-f segment -${1/=/ }" ;;
        filter=*) filter_add=,${1#filter=} ;;
        *) break;;
      esac
      shift
    done
    local filter="$mono$atempo$normalize$silenceremove$filter_add"
    if [[ $1 == play ]]; then
      ffplay -af "$filter" "$2"
      return
    fi
    _find_files_helper "*.mp3" "$@" | xargs -0 -P$(nproc) -I{} \
    sh -c '_f="{}"
        echo "$_f..."
        ffmpeg -v quiet -i "$_f" -vn \
        -af "'"$filter"'" \
    -q:a 8 '"$segment"' "${_f%.mp3}"-%2d.mp3 && gio trash "$_f"'
  }

  # normalize mp3 audio, move old files into the trash
  ffmpeg.normalize()
  {
    local normalize=dynaudnorm=100:15:0.99:s=3
    if [[ $1 == *dynaudnorm* ]]; then
      normalize=$1
      shift
    fi
    _find_files_helper "*.mp3" "$@" | xargs -0 -P$(nproc) -I{} \
    sh -c '_f="{}"
            echo "$_f..."
            _t=$(mktemp -u .tmp.XXX.mp3)
            ffmpeg -v quiet -i "$_f" -vn -af "'"$normalize"'" \
    -q:a 4 "$_t" && gio trash "$_f" && mv "$_t" "$_f"'
  }

  # check a file for errors
  ffmpeg.check()
  {
    for f in "$@"; do
      ffmpeg -v error -i "$f" -f null - && echo -n '[ OK ] ' || echo -n '[FAIL] '
      echo "'$f'"
    done
  }

  # better to use Peek;)
  screencast.win() {
    local wid=$(wmctrl -a :SELECT: -v |& grep ^Using)
    wid=${wid##* }
    local x y w h
    read -r _ _ _ x y w h _ < <(wmctrl -lpG | grep ^$wid)
    echo +$x+$y ${w}x$h
    ffmpeg -v panic -video_size ${w}x${h} -framerate 10 -f x11grab -i :0.0+$x,$y \
    -preset slow -y -c:v h264_nvenc \
    ~/screencast.mp4
  }
fi # end of ffmpeg
