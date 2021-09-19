#!/bin/sh
if [ "$1" ]; then
    file_path=$1
    file_name=$(basename "$file_path")
    if [ -f $file_path ]; then
	codename=$(echo $TARGET_PRODUCT | sed 's/corvus_//g')
        build_prop="out/target/product/${codename}/system/build.prop";
        name=$(grep ro\.product\.system\.model ${build_prop} | cut -d= -f2);
        version_codename=$(grep ro\.corvus\.codename ${build_prop} | cut -d= -f2);
        version=$(grep ro\.corvus\.build\.version ${build_prop} | cut -d= -f2);
        maintainer=$(echo $MAINTAINER)
        size=$(stat -c%s $file_path);
        datetime=$(grep ro\.build\.date\.utc ${build_prop} | cut -d= -f2);
        filehash=$(md5sum $file_path | awk '{ print $1 }');
        url=$(echo $PLING_URL)
        group=$(echo $GROUP_URL)
        echo "{" > $file_path.json
	echo "  \"codename\":\"${codename}\"," >> $file_path.json
        echo "  \"name\":\"${name}\"," >> $file_path.json
        echo "  \"version_codename\":\"${version_codename}\"," >> $file_path.json
        echo "  \"version\":\"${version}\"," >> $file_path.json
        echo "  \"maintainer\":\"${maintainer}\"," >> $file_path.json
        echo "  \"size\":${size}," >> $file_path.json
        echo "  \"datetime\":${datetime}," >> $file_path.json
        echo "  \"filehash\":\"${filehash}\"," >> $file_path.json
        echo "  \"url\":\"${url}\"," >> $file_path.json
        echo "  \"group\":\"${group}\"," >> $file_path.json
        echo "}" >> $file_path.json
        mv "${file_path}.json" "./${codename}.json"
        echo "JSON Generated: ${codename}.json"
    fi
fi
