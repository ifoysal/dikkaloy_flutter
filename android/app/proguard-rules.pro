# Flutter Proguard Rules for LiveMCQ User App

# Keep Flutter Wrapper & Engine
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.** { *; }
-keep class io.flutter.util.** { *; }
-keep class io.flutter.view.** { *; }
-keep class io.flutter.** { *; }
-keep class io.flutter.plugins.** { *; }

# Keep Data Models & JSON Serialization
-keepclassmembers class * {
    @com.google.gson.annotations.SerializedName <fields>;
}
-keep class livemcq_app.data.models.** { *; }
-keepclassmembers class livemcq_app.data.models.** { *; }

# Dio & Network Client
-dontwarn okio.**
-dontwarn javax.annotation.**
-keepattributes Signature
-keepattributes *Annotation*
-keep class okhttp3.** { *; }
-keep interface okhttp3.** { *; }
-dontwarn okhttp3.**

# Firebase Core & Messaging
-keep class com.google.firebase.** { *; }
-dontwarn com.google.firebase.**
