
echo "s#<$1>#\"HW/hls_include/$1\"#g"
sed -i "s#<$1>#\"HW/hls_include/$1\"#g" *.h
echo "s#\"$1\"#\"HW/hls_include/$1\"#g"
sed -i "s#\"$1\"#\"HW/hls_include/$1\"#g" *.h