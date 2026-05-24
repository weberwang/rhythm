allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

val newBuildDir: Directory =
    rootProject.layout.buildDirectory
        .dir("../../build")
        .get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
}
subprojects {
    project.evaluationDependsOn(":app")
}

subprojects {
    configurations.configureEach {
        resolutionStrategy.eachDependency {
            // home_widget 0.9.1 使用了 1.+ 的动态版本范围，这里钉住稳定版以避免拉到要求 AGP 9.1 / compileSdk 37 的 alpha 依赖。
            if (requested.group == "androidx.glance" && requested.name == "glance-appwidget") {
                useVersion("1.0.0")
                because("Pin home_widget transitive Glance dependency to a stable version compatible with AGP 8.9 and compileSdk 36")
            }
        }
    }
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
