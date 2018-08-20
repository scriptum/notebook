if hash scanimage scantailor-cli mogrify 2>/dev/null; then
  # scanner! you need to install scantailor-cli
  if hash jbig2 2>/dev/null; then
    _scans2pdf() {
      jbig2 -s -p "$@"
      python ~/.bin/pdf.py output
    }
    _scans_enhance() {
      mogrify -normalize -unsharp 0x4+1 out-*.pnm
      scantailor-cli --dpi=300 --output-dpi=300 --content-detection=cautious out-*.pnm .
    }
    _scan_common() {
      local outf=out
      [[ -n $2 ]] && outf="$2"
      /bin/rm -fr /tmp/.scans
      mkdir -p /tmp/.scans || return 1
      (
        cd /tmp/.scans
        if [[ $1 == single ]]; then
          scanimage --mode Gray --resolution 300 > out-0000.pnm || exit 1
        else
          scanimage --mode Gray --resolution 300 \
          --source $1 --batch=out-%04d.pnm || exit 1
        fi
        if [[ $1 == Duplex ]]; then
          ls out-*.pnm | awk '!(NR%2){print}' | xargs mogrify -rotate 180
        fi
        _scans_enhance
        _scans2pdf out-*.tif > "$outf.pdf"
      ) && mv "/tmp/.scans/$outf.pdf" .
    }
    scan.adf() {
      _scan_common ADF "$@"
    }
    scan.duplex() {
      _scan_common Duplex "$@"
    }
    scan.single() {
      _scan_common single "$@"
    }
  fi
fi
