/*
 * Copyright (C) 2024 Paranoid Android
 *
 * SPDX-License-Identifier: Apache-2.0
 */

package org.lineageos.settings.thermal

import android.service.quicksettings.Tile
import android.service.quicksettings.TileService
import android.util.Log
import org.lineageos.settings.R
import org.lineageos.settings.utils.FileUtils

class ThermalProfileTileService : TileService() {
    companion object {
        private const val TAG = "ThermalProfileTile"
        private const val THERMAL_PROFILE_PATH = "/sys/class/thermal/thermal_message/sconfig"
        private const val THERMAL_TILE_DEFAULT = 0
        private const val THERMAL_TILE_BENCHMARK = 1
        private const val THERMAL_TILE_GAMING = 2
        private const val THERMAL_TILE_STREAMING = 3

        private val VALID_PROFILES = listOf(
            THERMAL_TILE_DEFAULT,
            THERMAL_TILE_BENCHMARK,
            THERMAL_TILE_GAMING,
            THERMAL_TILE_STREAMING
        )
    }

    private fun updateUI(profile: Int) {
        qsTile?.let { tile ->
            tile.label = getString(R.string.thermal_tile_title)
            tile.subtitle = when (profile) {
                THERMAL_TILE_DEFAULT -> getString(R.string.thermal_default)
                THERMAL_TILE_BENCHMARK -> getString(R.string.thermal_benchmark)
                THERMAL_TILE_GAMING -> getString(R.string.thermal_gaming)
                THERMAL_TILE_STREAMING -> getString(R.string.thermal_streaming)
                else -> getString(R.string.thermal_default)
            }
            
            val isWritable = try {
                FileUtils.isFileWritable(THERMAL_PROFILE_PATH)
            } catch (e: Exception) {
                Log.e(TAG, "Error checking file writability", e)
                false
            }
            
            tile.state = if (isWritable) Tile.STATE_ACTIVE else Tile.STATE_UNAVAILABLE
            tile.updateTile()
        }
    }

    override fun onStartListening() {
        super.onStartListening()
        try {
            val currentProfile = FileUtils.readLineInt(THERMAL_PROFILE_PATH)
            val safeProfile = if (VALID_PROFILES.contains(currentProfile)) currentProfile else THERMAL_TILE_DEFAULT
            Log.d(TAG, "onStartListening: current profile=$currentProfile, safeProfile=$safeProfile")
            updateUI(safeProfile)
        } catch (e: Exception) {
            Log.e(TAG, "Error in onStartListening", e)
            updateUI(THERMAL_TILE_DEFAULT)
        }
    }

    override fun onClick() {
        super.onClick()
        try {
            val currentProfile = FileUtils.readLineInt(THERMAL_PROFILE_PATH)
            val newProfile = when (currentProfile) {
                THERMAL_TILE_DEFAULT -> THERMAL_TILE_BENCHMARK
                THERMAL_TILE_BENCHMARK -> THERMAL_TILE_GAMING
                THERMAL_TILE_GAMING -> THERMAL_TILE_STREAMING
                THERMAL_TILE_STREAMING -> THERMAL_TILE_DEFAULT
                else -> THERMAL_TILE_BENCHMARK
            }
            Log.d(TAG, "onClick: currentProfile=$currentProfile, newProfile=$newProfile")

            val writeSuccess = FileUtils.writeLine(THERMAL_PROFILE_PATH, newProfile)
            if (!writeSuccess) {
                Log.e(TAG, "Failed to write thermal profile $newProfile")
            }

            // Confirm by reading back the profile after writing
            val confirmedProfile = if (writeSuccess) {
                try {
                    val readBack = FileUtils.readLineInt(THERMAL_PROFILE_PATH)
                    if (VALID_PROFILES.contains(readBack)) readBack else newProfile
                } catch (e: Exception) {
                    Log.e(TAG, "Error reading back profile", e)
                    newProfile
                }
            } else {
                currentProfile
            }
            Log.d(TAG, "Confirmed profile after write: $confirmedProfile")
            updateUI(confirmedProfile)
        } catch (e: Exception) {
            Log.e(TAG, "Error in onClick", e)
            updateUI(THERMAL_TILE_DEFAULT)
        }
    }
}
