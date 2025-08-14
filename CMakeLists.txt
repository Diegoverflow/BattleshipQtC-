cmake_minimum_required(VERSION 3.16)

project(NavalBattle VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 REQUIRED COMPONENTS Quick)
find_package(Qt6 REQUIRED COMPONENTS Core)

qt_standard_project_setup(REQUIRES 6.8)

qt_add_executable(appNavalBattle
    main.cpp gamecontroller.h gamecontroller.cpp
)

qt_add_qml_module(appNavalBattle
    URI NavalBattle
    VERSION 1.0
    QML_FILES
        Main.qml
        RESOURCES assets/water.jpg
        QML_FILES GameBoard.qml
        QML_FILES GameIntro.qml
        QML_FILES PlayerPositiong.qml
        SOURCES gamecontroller.h gamecontroller.cpp
        QML_FILES LocalGameplay.qml
)

# Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1.
# If you are developing for iOS or macOS you should consider setting an
# explicit, fixed bundle identifier manually though.
set_target_properties(appNavalBattle PROPERTIES
#    MACOSX_BUNDLE_GUI_IDENTIFIER com.example.appNavalBattle
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(appNavalBattle
    PRIVATE Qt6::Quick
)
target_link_libraries(appNavalBattle PRIVATE Qt6::Core)

include(GNUInstallDirs)
install(TARGETS appNavalBattle
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
