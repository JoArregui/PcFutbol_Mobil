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

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}

// PARCHE ANTIBLOQUEO: Inyección de Identidad para Isar
subprojects {
    // Definimos la función del parche
    val applyIsarFix = {
        if (project.extensions.findByName("android") != null) {
            val android = project.extensions.getByName("android") as com.android.build.gradle.BaseExtension
            
            if (android.namespace == null) {
                android.namespace = "dev.isar.isar_flutter_libs"
            }

            project.tasks.withType<com.android.build.gradle.tasks.ProcessLibraryManifest>().configureEach {
                doLast {
                    val manifestFile = manifestOutputFile.get().asFile
                    if (manifestFile.exists()) {
                        val content = manifestFile.readText()
                        if (!content.contains("package=")) {
                            val updatedContent = content.replace("<manifest", "<manifest package=\"dev.isar.isar_flutter_libs\"")
                            manifestFile.writeText(updatedContent)
                        }
                    }
                }
            }
        }
    }

    // Si el proyecto ya se evaluó (caso de ./gradlew clean), ejecutamos directo.
    // Si no, esperamos al afterEvaluate.
    if (project.state.executed) {
        applyIsarFix()
    } else {
        project.afterEvaluate {
            applyIsarFix()
        }
    }
}