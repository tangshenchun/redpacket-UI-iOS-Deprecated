build_bundles=($1)

for bundle_target in ${build_bundles[*]}
do
echo "Bundle Bulid $bundle_target"
xcodebuild -project RedpacketLib.xcodeproj -target $bundle_target -configuration ${CONFIGURATION} -sdk iphoneos  BUILD_DIR="${BUILD_DIR}" BUILD_ROOT="${BUILD_ROOT}"
done

file_copy_path="${BUILD_DIR}/${CONFIGURATION}-iphoneos/"
file_copyTo_basePath="./Redpacket-UI-lib/"

i=0

for bundle_target in ${build_bundles[*]}
do

file_copyTo_path="${file_copyTo_basePath}/resources/"

rm -rf $file_copyTo_path
mkdir -p $file_copyTo_path

file_copy="${file_copy_path}${bundle_target}.bundle"

cp -rf  $file_copy "${file_copyTo_path}RedpacketBundle.bundle"

i=`expr $i+1`

done

echo "Bundle Bulid Finish"
