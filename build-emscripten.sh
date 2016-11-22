emconfigure ./configure CXXFLAGS='-DOTS_DEBUG -s USE_ZLIB=1' --without-zlib
emmake make -j10

python $EMSCRIPTEN/tools/webidl_binder.py util/ots.idl util/glue
em++ -I. -Iinclude -DOTS_DEBUG util/glue_wrapper.cpp -c -o util/glue_wrapper.o

em++ -DOTS_DEBUG -s USE_ZLIB=1 -o sanitise.js util/glue_wrapper.o libots.a libwoff2.a libbrotli.a --post-js util/glue.js
