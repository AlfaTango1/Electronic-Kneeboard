#!/usr/bin/env bash
# Adds GPS permissions and keeps the screen on while the app is open.
set -euo pipefail
M=android/app/src/main/AndroidManifest.xml
if ! grep -q ACCESS_FINE_LOCATION "$M"; then
  sed -i 's#</manifest>#    <uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION" />\n    <uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />\n    <uses-feature android:name="android.hardware.location.gps" android:required="false" />\n</manifest>#' "$M"
fi
MA=$(find android/app/src/main/java -name MainActivity.java | head -n1)
PKG=$(sed -n 's/^package \(.*\);/\1/p' "$MA")
cat > "$MA" <<JAVA
package ${PKG};

import android.os.Bundle;
import android.view.WindowManager;
import com.getcapacitor.BridgeActivity;

public class MainActivity extends BridgeActivity {
    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        getWindow().addFlags(WindowManager.LayoutParams.FLAG_KEEP_SCREEN_ON);
    }
}
JAVA
echo "Android project patched"
