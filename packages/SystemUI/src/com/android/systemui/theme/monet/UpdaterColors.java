/*
 * Copyright (C) 2018 The Android Open Source Project
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

package com.android.systemui.theme.monet;

import com.android.systemui.theme.monet.ColorScheme;
import android.app.WallpaperManager;
import android.graphics.Bitmap;
import android.graphics.Color;
import android.graphics.drawable.BitmapDrawable;
import android.graphics.drawable.Drawable;
import androidx.palette.graphics.Palette;
import androidx.core.graphics.ColorUtils;
import android.content.Context;
import android.app.WallpaperManager;
import android.app.ActivityThread;
import android.app.UiModeManager;
import android.os.PowerManager;
import android.os.UserHandle;
import android.provider.Settings;
import android.graphics.Color;
import android.annotation.NonNull;

public class UpdaterColors {

    int defaultColor = 0x000000;
    final Context app = ActivityThread.currentApplication();
    boolean useMonet = true;
    private WallpaperManager wallpaperManager;
    private Drawable wallpaperDrawable;
    private Bitmap bitmap;
    private Palette p;
    private ColorScheme colorscheme;

    public UpdaterColors(@NonNull Context context) {
        wallpaperManager = WallpaperManager.getInstance(context);
        wallpaperDrawable = wallpaperManager.getDrawable();
        bitmap = ((BitmapDrawable)wallpaperDrawable).getBitmap();
        p = Palette.from(bitmap).generate();
        colorscheme = new ColorScheme(p.getDominantColor(defaultColor), false);
    }


    public int mainBG(Context context){
        int k = isDarkM(context) ? Color.BLACK : Color.WHITE;
        if(useMonet){
            k = isDarkM(context) ? colorscheme.getColor(4, 10) : colorscheme.getColor(4, 0);
        }
        return k;
    }

    public int secBG(Context context){
        int k = isDarkM(context) ? Color.parseColor("#161616") : Color.parseColor("#f2f2f2"); 
        if(useMonet){
            k = isDarkM(context) ? colorscheme.getColor(4, 9) : colorscheme.getColor(4, 1);
        }
        return k;
    }

    public int primaryCol(Context context){
        int k = isDarkM(context) ? Color.WHITE : Color.BLACK;
        if (useMonet){
            k = isDarkM(context) ? colorscheme.getColor(3, 5) : colorscheme.getColor(1, 7);
        }
        return k;
    }

    public int secondaryCol(Context context){
        int k = Color.GRAY;
        if (useMonet){
            k = isDarkM(context) ? colorscheme.getColor(2, 2) : colorscheme.getColor(1, 10);
        }
        return k;
    }

    public int iconCol(Context context){
        int k = isDarkM(context) ? colorscheme.getColor(3, 6) : colorscheme.getColor(1, 7);
        return k;
    }

    public int headerCol(Context context){
        int k = isDarkM(context) ? Color.WHITE : Color.BLACK;
        if (useMonet){
            k = isDarkM(context) ? colorscheme.getColor(5, 0) : colorscheme.getColor(1, 7);
        }
        return k;
    }

    public boolean isDarkM(Context context){
        UiModeManager mUiModeManager = context.getSystemService(UiModeManager.class);
        if (mUiModeManager.getNightMode() != UiModeManager.MODE_NIGHT_NO || isPowerSave(context)){
            // dark
            return true;
        } else{
            // light
            return false;
        }
    }

    public boolean isPowerSave(Context context){
        PowerManager mPowerManager = context.getSystemService(PowerManager.class);
        if(mPowerManager.isPowerSaveMode()){
            return true;
        }
        else{
            return false;
        }
    }

}
