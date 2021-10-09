package com.android.systemui.theme.monet

import com.android.systemui.theme.monet.Cam

public class ColorScheme(rgb: Int, public val darkTheme: Boolean = false) {
    val hue: Double = Cam.fromInt(rgb).hue
    val accent1 = Shades.of(hue, 48.0)
    val accent2 = Shades.of(hue, 16.0)
    val accent3 = Shades.of(hue + 60.0, 32.0)
    val neutral1 = Shades.of(hue, 4.0)
    val neutral2 = Shades.of(hue, 8.0)

    public fun getColor(va: Int, vc: Int): Int{  
        if (va==2){
            return accent2[vc]
        } 
        if (va==3){
            return accent3[vc]
        }
        if (va==4){
            return neutral1[vc]
        }
        if (va==5){
            return neutral2[vc]
        }
        if (va==1){
            return accent1[vc]
        } else{
            return accent1[vc]
        }
    }

}