package com.android.systemui.theme;

import java.util.ArrayList;
import java.util.List;
import com.android.systemui.theme.monet.ColorGiber;
import android.content.Context;
import java.util.Arrays;
public final class ColorScheme {
    private final List<Integer> accent1;
    private final List<Integer> accent2;
    private final List<Integer> accent3;
    private final List<Integer> neutral1;
    private final List<Integer> neutral2;
    Integer[] iArr1 = new Integer[12];
    Integer[] iArr2 = new Integer[12];
    Integer[] iArr3 = new Integer[12];
    Integer[] iArr4 = new Integer[12];
    Integer[] iArr5 = new Integer[12];
    public ColorScheme(Context context) {
        ColorGiber cg = new ColorGiber(context);
        int i = 0;
        while (i < 12) {
            iArr1[i] = cg.bclr(1, i);
            iArr2[i] = cg.bclr(2, i);
            iArr3[i] = cg.bclr(3, i);
            iArr4[i] = cg.bclr(4, i);
            iArr5[i] = cg.bclr(5, i);
            i=i+1;
        }
        accent1 = Arrays.asList(iArr1);
        accent2 = Arrays.asList(iArr2);
        accent3 = Arrays.asList(iArr3);
        neutral1 = Arrays.asList(iArr4);
        neutral2 = Arrays.asList(iArr5);
    }

    public final List<Integer> getAccent1() {
        return accent1;
    }

    public final int getAccent1MAIN() {
        return iArr1[3];
    }

    public final int getN2MAIN() {
        return iArr5[8];
    }

    public final List<Integer> getAllAccentColors() {
        ArrayList arrayList = new ArrayList();
        arrayList.addAll(accent1);
        arrayList.addAll(accent2);
        arrayList.addAll(accent3);
        return arrayList;
    }

    public final List<Integer> getAllNeutralColors() {
        ArrayList arrayList = new ArrayList();
        arrayList.addAll(neutral1);
        arrayList.addAll(neutral2);
        return arrayList;
    }

}
