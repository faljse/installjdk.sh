#!/bin/sh

set -eu

priority=2222
#jdk_base_dir=/usr/lib/jvm/adoptopenjdk-11-hotspot-amd64
#jdk_base_dir=/usr/lib/jvm/jdk-17.0.1+12
jdk_base_dir="$2"

if [ ! -d "$jdk_base_dir" ]
then
    echo "Invalid java directory. Choose one of: ";
    ls -1d /usr/lib/jvm/*
    exit
fi

tools="jaotc jar jarsigner java javac javadoc javap jcmd jconsole jdb jdeprscan jdeps jfr jhsdb jimage jinfo jjs jlink jmap jmod jps jrunscript jshell jstack jstat jstatd keytool pack200 rmic rmid rmiregistry serialver unpack200 jexec jspawnhelper"

case "$1" in
install)
    for tool in $tools ; do
        for tool_path in "$jdk_base_dir/bin/$tool" "$jdk_base_dir/lib/$tool" ; do
            if [ ! -e "$tool_path" ]; then
                continue
            fi

            slave=""
            tool_man_path="$jdk_base_dir/man/man1/$tool.1"
            if [ -e "$tool_man_path" ]; then
                slave="--slave /usr/share/man/man1/$tool.1 $tool.1 $tool_man_path"
            fi

            update-alternatives \
                --install \
                "/usr/bin/$tool" \
                "$tool" \
                "$tool_path" \
                "$priority" \
                $slave
        done
    done
;;
remove)
    for tool in $tools ; do
        for tool_path in "$jdk_base_dir/bin/$tool" "$jdk_base_dir/lib/$tool" ; do
            if [ ! -e "$tool_path" ]; then
                continue
            fi

            update-alternatives \
                --remove \
                "$tool" \
                "$tool_path"
        done
    done
;;
set)
    for tool in $tools ; do
        for tool_path in "$jdk_base_dir/bin/$tool" "$jdk_base_dir/lib/$tool" ; do
            if [ ! -e "$tool_path" ]; then
                continue
            fi

            update-alternatives \
                --set \
                "$tool" \
                "$tool_path"
        done
    done
;;
esac
