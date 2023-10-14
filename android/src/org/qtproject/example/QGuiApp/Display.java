package org.qtproject.example.QGuiApp;

import android.util.Log;

public class Display {
    public static void display(String message){
        try {
            String text = message;
            System.out.println("Java: " + text);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
