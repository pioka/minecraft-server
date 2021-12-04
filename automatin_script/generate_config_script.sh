#!/bin/sh

# server.propertiesファイルを生成するスクリプトを生成するスクリプト

SERVER_PROP_FILE=./server.properties.default
SCRIPT_DIST=../generate_server_properties.sh

cat << EOS > $SCRIPT_DIST
#!/bin/sh
cat << EOS
EOS

num_lines=`wc -l < $SERVER_PROP_FILE`
for i in `seq $num_lines`; do
  # load line
  line=`sed -n ${i}p $SERVER_PROP_FILE`

  if echo $line | grep -q -v '='; then
    continue
  fi

  key=`echo $line | cut -d= -f1`
  value=`echo $line | cut -d= -f2`

  env_key="MC_PROP_`echo $key | tr '[:lower:]' '[:upper:]' | tr '-' '_' | tr '.' '_'`"

  echo "${key}=\${${env_key}:-${value}}" >> $SCRIPT_DIST
done
echo 'EOS' >> $SCRIPT_DIST

chmod +x $SCRIPT_DIST
