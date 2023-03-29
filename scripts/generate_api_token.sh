SRC_ROOT=$(git rev-parse --show-toplevel)
echo $SRC_ROOT
FILE="$SRC_ROOT/Frameworks/PNetwork/Sources/RawgAPI/Utils/ApiEnvironment.swift"
echo $FILE

$SRC_ROOT/tools/bin/sourcery --templates $SRC_ROOT/templates/Sourcery/ApiEnvironment.stencil --sources $SRC_ROOT/templates/Sourcery/ApiEnvironment.stencil --output $FILE --args apiToken=$RAWG_API_TOKEN