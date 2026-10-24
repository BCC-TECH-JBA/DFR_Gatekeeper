package com.fixtrack;

import com.fixtrack.util.DatabaseInitializer;

//TIP To <b>Run</b> code, press <shortcut actionId="Run"/> or
// click the <icon src="AllIcons.Actions.Execute"/> icon in the gutter.
public class Main {
    public static void main() {
        //TEST CREATION OF DATABASE
        DatabaseInitializer.init();
        System.out.println("Running");
    }
}
