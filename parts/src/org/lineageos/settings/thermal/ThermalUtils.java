/*
 * Copyright (C) 2020 The LineageOS Project
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package org.lineageos.settings.thermal;

import org.lineageos.settings.utils.FileUtils;
import android.content.Context;
import android.content.Intent;
import android.content.SharedPreferences;
import android.os.UserHandle;
import android.util.Log;

import androidx.preference.PreferenceManager;

public final class ThermalUtils {

    // Add to ThermalUtils.java for better logging
    private static final boolean DEBUG = true;
    private static final String TAG = "ThermalUtils";

    private static final String THERMAL_CONTROL = "thermal_control";
    private static final String THERMAL_SERVICE = "thermal_service";

    protected static final int STATE_DEFAULT = 0;
    protected static final int STATE_BENCHMARK = 1;
    protected static final int STATE_GAMING = 2;
    protected static final int STATE_STREAMING = 3;

    private static final String THERMAL_BENCHMARK = "thermal.benchmark=";
    private static final String THERMAL_GAMING = "thermal.gaming=";
    private static final String THERMAL_STREAMING = "thermal.streaming=";

    private static final String THERMAL_SCONFIG = "/sys/class/thermal/thermal_message/sconfig";

    private SharedPreferences mSharedPrefs;

    protected ThermalUtils(Context context) {
        mSharedPrefs = PreferenceManager.getDefaultSharedPreferences(context);
    }

    public static void initialize(Context context) {
        if (isServiceEnabled(context))
            startService(context);
        else
            setDefaultThermalProfile();
    }

    protected static void startService(Context context) {
        context.startServiceAsUser(new Intent(context, ThermalService.class),
                UserHandle.CURRENT);
        PreferenceManager.getDefaultSharedPreferences(context).edit()
            .putString(THERMAL_SERVICE, "true").apply();
    }

    protected static void stopService(Context context) {
        context.stopService(new Intent(context, ThermalService.class));
        PreferenceManager.getDefaultSharedPreferences(context).edit()
            .putString(THERMAL_SERVICE, "false").apply();
    }

    protected static boolean isServiceEnabled(Context context) {
        // Here you can add actual check for user preference or settings
        return true;
    }

    private void writeValue(String profiles) {
        mSharedPrefs.edit().putString(THERMAL_CONTROL, profiles).apply();
    }

    private String getValue() {
        String value = mSharedPrefs.getString(THERMAL_CONTROL, null);

        if (value == null || value.isEmpty()) {
            // Initialize with empty profile entries for each mode
            value = THERMAL_BENCHMARK + ":" + THERMAL_GAMING + ":" + THERMAL_STREAMING;
            writeValue(value);
        }
        return value;
    }

    /**
     * Write or update thermal mode assignment for a package.
     * @param packageName the app package name
     * @param mode one of STATE_DEFAULT, STATE_BENCHMARK, STATE_GAMING, STATE_STREAMING
     */
    protected void writePackage(String packageName, int mode) {
        String value = getValue();

        // Split stored string into modes
        String[] modes = value.split(":");
        if (modes.length < 3) {
            // Sanity check; if format corrupted reset
            modes = new String[] {THERMAL_BENCHMARK, THERMAL_GAMING, THERMAL_STREAMING};
        }

        // Remove package from all modes to avoid duplicates
        for (int i = 0; i < modes.length; i++) {
            modes[i] = removePackageFromMode(modes[i], packageName);
        }

        // Add package to selected mode if not default
        switch (mode) {
            case STATE_BENCHMARK:
                modes[0] += packageName + ",";
                break;
            case STATE_GAMING:
                modes[1] += packageName + ",";
                break;
            case STATE_STREAMING:
                modes[2] += packageName + ",";
                break;
            case STATE_DEFAULT:
            default:
                // Do not add package to any specific mode (default)
                break;
        }

        // Join updated string and save
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < modes.length; i++) {
            sb.append(modes[i]);
            if (i < modes.length - 1) sb.append(":");
        }
        writeValue(sb.toString());
    }

    private String removePackageFromMode(String modeString, String packageName) {
        return modeString.replace(packageName + ",", "");
    }

    /**
     * Return thermal state for a package by checking which mode list it belongs to.
     * @param packageName package name of the app
     * @return one of STATE_DEFAULT, STATE_BENCHMARK, STATE_GAMING, STATE_STREAMING
     */
    protected int getStateForPackage(String packageName) {
        String value = getValue();
        String[] modes = value.split(":");
        if (modes.length < 3) {
            return STATE_DEFAULT;
        }
        if (modes[0].contains(packageName + ",")) {
            return STATE_BENCHMARK;
        }
        if (modes[1].contains(packageName + ",")) {
            return STATE_GAMING;
        }
        if (modes[2].contains(packageName + ",")) {
            return STATE_STREAMING;
        }
        return STATE_DEFAULT;
    }

    /**
     * Sets thermal profile based on the package currently in foreground.
     */
    protected void setThermalProfile(String packageName) {
        int mode = getStateForPackage(packageName);
        setThermalProfileMode(mode);
    }

    /**
     * Sets the system thermal profile to default.
     */
    protected static void setDefaultThermalProfile() {
        setThermalProfileMode(STATE_DEFAULT);
    }

    /**
     * Write the mode to the thermal sysfs path.
     * @param mode the thermal mode int
     */
    private static void setThermalProfileMode(int mode) {
        if (DEBUG) Log.d(TAG, "Setting thermal profile to: " + mode);
        String modeStr = String.valueOf(mode);
        // Write to sysfs to control thermal profile (this path is example)
        FileUtils.writeLine(THERMAL_SCONFIG, modeStr);
    }
}
