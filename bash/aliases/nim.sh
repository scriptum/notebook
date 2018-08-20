if hash nim 2>/dev/null; then # nim
  alias nbi='nimble install'
  alias nbs='nimble search'
  alias nimr='nim c -d:release --embedsrc --cc:clang'
  alias nimc='nim c -d:release --embedsrc'
  if hash cilly 2>/dev/null; then
    nim.cilly() {
      nim cc -c --genScript -d:release  --embedsrc "$@" && {
        local script=$(echo compile_*.sh)
        sed -i 's/^gcc/cilly --merge --keepmerged/' $script
        cp -f $HOME/git/Nim/lib/nimbase.h nimcache/
        # sed -i 's@define N_NIMCALL([^)]*)@& static inline@' nimcache/nimbase.h
        mv -f $script nimcache/
        pushd nimcache >/dev/null
        bash $script
        [[ -f ${1%.nim} ]] && mv -f ${1%.nim} ../${1%.nim}
        popd >/dev/null
      }
    }
  fi
fi # end of nim
