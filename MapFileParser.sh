#!/bin/sh
if [ "$UNITY_SCRIPTING_BACKEND" = "il2cpp" ]
then
    if [ -f "$PROJECT_DIR/MapFileParser" ] && [ -x "$PROJECT_DIR/MapFileParser" ]
    then
        if [[ $ARCHS == *"armv7"* ]]
        then
            "$PROJECT_DIR/MapFileParser" -format=Clang "$TARGET_TEMP_DIR/$PRODUCT_NAME-LinkMap-$CURRENT_VARIANT-armv7.txt" "$CONFIGURATION_BUILD_DIR/$PRODUCT_NAME.app/Data/Managed/SymbolMap-32" || true
        fi
    else
        echo "The MapFileParser utility was not found or is not executable. Managed stack traces may not be reported correctly."
    fi
fi
exit 0

