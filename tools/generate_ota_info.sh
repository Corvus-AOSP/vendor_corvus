#!/bin/sh
if [ "$1" ]; then
    file_path=$1
    file_name=$(basename "$file_path")
    if [ -f $file_path ]; then
		device_name=$(echo $TARGET_PRODUCT | cut -d "_" -f2)
        build_prop="out/target/product/${device_name}/system/build.prop";
        oem=$(grep ro\.product\.system\.brand ${build_prop} | cut -d= -f2);
        name=$(grep ro\.product\.system\.device ${build_prop} | cut -d= -f2);
        codename=$(grep ro\.corvus\.codename ${build_prop} | cut -d= -f2);
        version=$(grep ro\.corvus\.build\.version ${build_prop} | cut -d= -f2);
        romtype=$(grep ro\.corvus\.build\.type ${build_prop} | cut -d= -f2);
        maintainer=$(grep ro\.corvus\.maintainer ${build_prop} | cut -d= -f2);
        size=$(stat -c%s $file_path);
        datetime=$(grep ro\.build\.date\.utc ${build_prop} | cut -d= -f2);
        filehash=$(md5sum $file_path | awk '{ print $1 }');
        id=$(sha256sum $file_path | awk '{ print $1 }');
        url="https://ota.corvusrom.com/${device_name}/${file_name}";
        echo "{" > $file_path.json
        echo "  \"oem\":\"${oem}\"," >> $file_path.json
        echo "  \"name\":\"${name}\"," >> $file_path.json
        echo "  \"codename\":\"${codename}\"," >> $file_path.json
        echo "  \"filename\":\"${file_name}\"," >> $file_path.json
        echo "  \"version\":\"${version}\"," >> $file_path.json
        echo "  \"romtype\":\"${romtype}\"," >> $file_path.json
        echo "  \"maintainer\":\"${maintainer}\"," >> $file_path.json
        echo "  \"size\":${size}," >> $file_path.json
        echo "  \"datetime\":${datetime}," >> $file_path.json
        echo "  \"filehash\":\"${filehash}\"," >> $file_path.json
        echo "  \"id\":\"${id}\"," >> $file_path.json
        echo "  \"url\":\"${url}\"," >> $file_path.json
        echo "}" >> $file_path.json
        mv "${file_path}.json" "./${device_name}.json"
        echo "JSON Generated: ${device_name}.json"
    fi
fi
