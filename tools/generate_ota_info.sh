        device_name=$(echo $file_name | cut -d'-' -f5);
        build_prop="out/target/product/${device_name}/system/build.prop";
        name=$(grep ro\.product\.system\.device ${build_prop} | cut -d= -f2);
        codename=$(grep ro\.corvus\.device ${build_prop} | cut -d= -f2);
        version=$(grep ro\.corvus\.version ${build_prop} | cut -d= -f2);
        romtype=$(grep ro\.corvus\.releasetype ${build_prop} | cut -d= -f2);
        variant=$(grep ro\.corvus\.build\.variant ${build_prop} | cut -d= -f2);
        variant_lower=$(echo ${variant} | tr '[:upper:]' '[:lower:]');
        maintainer=$(grep ro\.corvus\.maintainer ${build_prop} | cut -d= -f2);
        size=$(stat -c%s $file_path);
        datetime=$(grep ro\.build\.date\.utc ${build_prop} | cut -d= -f2);
        filehash=$(md5sum $file_path | awk '{ print $1 }');
        id=$(sha256sum $file_path | awk '{ print $1 }');
        url="https://ota.corvusrom.com/${device_name}/${file_name}";
        group=$(grep ro\.corvus\.group\.url ${build_prop} | cut -d= -f2);
        echo "{" > $file_path.json
        echo "  \"name\":\"${name}\"," >> $file_path.json
        echo "  \"codename\":\"${codename}\"," >> $file_path.json
        echo "  \"filename\":\"${file_name}\"," >> $file_path.json
        echo "  \"version\":\"${version}\"," >> $file_path.json
        echo "  \"romtype\":\"${romtype}\"," >> $file_path.json
        echo "  \"variant\":\"${variant}\"," >> $file_path.json
        echo "  \"maintainer\":\"${maintainer}\"," >> $file_path.json
        echo "  \"size\":${size}," >> $file_path.json
        echo "  \"datetime\":${datetime}," >> $file_path.json
        echo "  \"filehash\":\"${filehash}\"," >> $file_path.json
        echo "  \"id\":\"${id}\"," >> $file_path.json
        echo "  \"url\":\"${url}\"," >> $file_path.json
        echo "  \"group\":\"${group}\"" >> $file_path.json
        echo "}" >> $file_path.json
        mv "${file_path}.json" "./${device_name}.json"
        echo "JSON Generated: ${device_name}.json"
    fi
fi
