FROM debian:12-slim
MAINTAINER mailsvb <mailsvb@gmail.com>
ENV ASTERISK_VERSION 20-current

RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y pkg-config make gcc g++ curl libcurl4-openssl-dev bzip2 patch \
        libnewt-dev libncurses5-dev libssl-dev libxml2-dev uuid-dev libjansson-dev libspeex-dev libsrtp2-dev libsqlite3-dev \
        libopus-dev libgsm1-dev libspeexdsp-dev libresample1-dev libvorbis-dev libogg-dev libopusfile-dev xmlstarlet libedit-dev liburiparser-dev && \
    mkdir -p /tmp/asterisk && cd /tmp/asterisk && \
    curl -sL http://downloads.asterisk.org/pub/telephony/asterisk/asterisk-${ASTERISK_VERSION}.tar.gz | tar --strip-components 1 -xvz && \
    ./configure --with-pjproject-bundled --disable-xmldoc --without-bfd --without-execinfo --without-bluetooth --without-cap --without-cpg --without-dahdi --without-gsm --without-gtk2 --without-hoard --without-ical --without-iconv --without-iksemel --without-imap --without-inotify --without-iodbc --without-jack --without-kqueue --without-ldap --without-lua --without-mysqlclient --without-neon --without-neon29 --without-netsnmp --without-newt --without-popt --without-openr2 --without-osptk --without-postgres --without-portaudio --without-pri --without-radius --without-resample --without-sdl --without-SDL_image --without-spandsp --without-ss7 --without-tds --without-timerfd --without-unixodbc --without-x11 && \
    make menuselect.makeopts && \
    for c in WAV ULAW ALAW G729 G722 SLN16; do ./menuselect/menuselect --enable CORE-SOUNDS-EN-${c} menuselect.makeopts; done && \
    ./menuselect/menuselect --enable app_saycounted menuselect.makeopts && \
    ./menuselect/menuselect --enable codec_opus menuselect.makeopts && \
    ./menuselect/menuselect --enable codec_silk menuselect.makeopts && \
    ./menuselect/menuselect --disable codec_g729a menuselect.makeopts && \
    ./menuselect/menuselect --disable chan_mgcp menuselect.makeopts && \
    ./menuselect/menuselect --disable chan_skinny menuselect.makeopts && \
    ./menuselect/menuselect --disable chan_unistim menuselect.makeopts && \
    ./menuselect/menuselect --disable chan_sip menuselect.makeopts && \
    ./menuselect/menuselect --disable cdr_custom menuselect.makeopts && \
    ./menuselect/menuselect --disable cdr_manager menuselect.makeopts && \
    ./menuselect/menuselect --disable cdr_csv menuselect.makeopts && \
    ./menuselect/menuselect --disable pbx_realtime menuselect.makeopts && \
    ./menuselect/menuselect --disable pbx_ael menuselect.makeopts && \
    ./menuselect/menuselect --disable pbx_dundi menuselect.makeopts && \
    ./menuselect/menuselect --disable astcanary menuselect.makeopts && \
    ./menuselect/menuselect --disable astdb2sqlite3 menuselect.makeopts && \
    ./menuselect/menuselect --disable astdb2bdb menuselect.makeopts && \
    ./menuselect/menuselect --disable cdr_sqlite3_custom menuselect.makeopts && \
    ./menuselect/menuselect --disable cel_sqlite3_custom menuselect.makeopts && \
    ./menuselect/menuselect --disable CORE-SOUNDS-EN-GSM menuselect.makeopts && \
    make clean && make && make install && rm -rf /tmp/* && \
    rm -Rf /usr/lib/pkgconfig/* && \
    apt-get remove --purge -y pkg-config make gcc g++ curl libcurl4-openssl-dev bzip2 patch libnewt-dev libncurses5-dev libssl-dev libxml2-dev \
    uuid-dev libjansson-dev libspeex-dev libsrtp2-dev libsqlite3-dev libopus-dev libgsm1-dev libspeexdsp-dev libresample1-dev libvorbis-dev \
    libogg-dev libopusfile-dev xmlstarlet libedit-dev liburiparser-dev && \
    apt-get autoremove --purge -y && rm -rf /var/lib/apt/lists/* && \
    apt-get update && \
    apt-get install -y libnewt0.52 libncurses5 openssl libxml2 uuid-runtime libjansson4 libspeex1 libsrtp2-1 sqlite3 libopus0 libgsm1 libspeexdsp1 \
        libresample1 libvorbis0a libvorbisenc2 libvorbisfile3 libopusfile0 xmlstarlet libcurl4 libedit2 liburiparser1

ADD config /etc/asterisk/
