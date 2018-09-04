

########################################################################################################################
########################################################################################################################
########################################################################################################################

function( __cmut__qt5__module_to_component__is_data_defined result )

    get_property( defined GLOBAL PROPERTY CMUT__QT5__MODULE_TO_COMPONENT_DEFINED)

    set( ${result} ${defined} PARENT_SCOPE )

endfunction()

########################################################################################################################

function( __cmut__qt5__module_to_component__set_data_defined defined )

    set_property( GLOBAL PROPERTY CMUT__QT5__MODULE_TO_COMPONENT_DEFINED ${defined} )

endfunction()

########################################################################################################################

macro( __cmut__qt5__module_to_component__define_relation module component )

    set_property( GLOBAL PROPERTY CMUT__QT5__MODULE_TO_COMPONENT__${module} ${component} )

    get_property( modules GLOBAL PROPERTY CMUT__QT5__COMPONENT_TO_MODULES__${component} )
    list( APPEND modules ${module} )
    set_property( GLOBAL PROPERTY CMUT__QT5__COMPONENT_TO_MODULES__${component} ${modules} )

endmacro()

########################################################################################################################

function(__cmut__qt5__module_to_component__define_data)

    __cmut__qt5__module_to_component__define_relation( "3DAnimation" "qt3d" )
    __cmut__qt5__module_to_component__define_relation( "3DCore" "qt3d" )
    __cmut__qt5__module_to_component__define_relation( "3DCoreTest" "qt3d" )
    __cmut__qt5__module_to_component__define_relation( "3DExtras" "qt3d" )
    __cmut__qt5__module_to_component__define_relation( "3DInput" "qt3d" )
    __cmut__qt5__module_to_component__define_relation( "3DLogic" "qt3d" )
    __cmut__qt5__module_to_component__define_relation( "3DQuickAnimation" "qt3d" )
    __cmut__qt5__module_to_component__define_relation( "3DQuickExtras" "qt3d" )
    __cmut__qt5__module_to_component__define_relation( "3DQuickInput" "qt3d" )
    __cmut__qt5__module_to_component__define_relation( "3DQuick" "qt3d" )
    __cmut__qt5__module_to_component__define_relation( "3DQuickRender" "qt3d" )
    __cmut__qt5__module_to_component__define_relation( "3DQuickScene2D" "qt3d" )
    __cmut__qt5__module_to_component__define_relation( "3DRender" "qt3d" )
    __cmut__qt5__module_to_component__define_relation( "AccessibilitySupport" "qtbase" )
    __cmut__qt5__module_to_component__define_relation( "AndroidBearer" "qtbase" )
    __cmut__qt5__module_to_component__define_relation( "AndroidBluetooth" "qtconnectivity" )
    __cmut__qt5__module_to_component__define_relation( "AndroidExtras" "qtandroidextras" )
    __cmut__qt5__module_to_component__define_relation( "AndroidGamepad" "qtgamepad" )
    __cmut__qt5__module_to_component__define_relation( "Android" "qtbase" )
    __cmut__qt5__module_to_component__define_relation( "AndroidWebView" "qtwebview" )
    __cmut__qt5__module_to_component__define_relation( "AxContainer" "qtactiveqt" )
    __cmut__qt5__module_to_component__define_relation( "AxServer" "qtactiveqt" )
    __cmut__qt5__module_to_component__define_relation( "Bluetooth" "qtconnectivity" )
    __cmut__qt5__module_to_component__define_relation( "BootstrapDBus" "qtbase" )
    __cmut__qt5__module_to_component__define_relation( "Bootstrap" "qtbase" )
    __cmut__qt5__module_to_component__define_relation( "Charts" "qtcharts" )
    __cmut__qt5__module_to_component__define_relation( "ClipboardSupport" "qtbase" )
    __cmut__qt5__module_to_component__define_relation( "Concurrent" "qtbase" )
    __cmut__qt5__module_to_component__define_relation( "Core" "qtbase" )
    __cmut__qt5__module_to_component__define_relation( "DataVisualization" "qtdatavis3d" )
    __cmut__qt5__module_to_component__define_relation( "DBus" "qtbase" )
    __cmut__qt5__module_to_component__define_relation( "DesignerComponents" "qttools" )
    __cmut__qt5__module_to_component__define_relation( "Designer" "qttools" )
    __cmut__qt5__module_to_component__define_relation( "DeviceDiscoverySupport" "qtbase" )
    __cmut__qt5__module_to_component__define_relation( "EdidSupport" "qtbase" )
    __cmut__qt5__module_to_component__define_relation( "EglFSDeviceIntegration" "qtbase" )
    __cmut__qt5__module_to_component__define_relation( "EglFsKmsSupport" "qtbase" )
    __cmut__qt5__module_to_component__define_relation( "EglSupport" "qtbase" )
    __cmut__qt5__module_to_component__define_relation( "EventDispatcherSupport" "qtbase" )
    __cmut__qt5__module_to_component__define_relation( "FbSupport" "qtbase" )
    __cmut__qt5__module_to_component__define_relation( "FontDatabaseSupport" "qtbase" )
    __cmut__qt5__module_to_component__define_relation( "Gamepad" "qtgamepad" )
    __cmut__qt5__module_to_component__define_relation( "GlxSupport" "qtbase" )
    __cmut__qt5__module_to_component__define_relation( "GraphicsSupport" "qtbase" )
    __cmut__qt5__module_to_component__define_relation( "Gui" "qtbase" )
    __cmut__qt5__module_to_component__define_relation( "Help" "qttools" )
    __cmut__qt5__module_to_component__define_relation( "InputSupport" "qtbase" )
    __cmut__qt5__module_to_component__define_relation( "KmsSupport" "qtbase" )
    __cmut__qt5__module_to_component__define_relation( "LinguistTools" qttools)
    __cmut__qt5__module_to_component__define_relation( "LinuxAccessibilitySupport" "qtbase" )
    __cmut__qt5__module_to_component__define_relation( "Location" "qtlocation" )
    __cmut__qt5__module_to_component__define_relation( "MacExtras" "qtmacextras" )
    __cmut__qt5__module_to_component__define_relation( "MultimediaGstTools" "qtmultimedia" )
    __cmut__qt5__module_to_component__define_relation( "Multimedia" "qtmultimedia" )
    __cmut__qt5__module_to_component__define_relation( "MultimediaQuick" "qtmultimedia" )
    __cmut__qt5__module_to_component__define_relation( "MultimediaWidgets" "qtmultimedia" )
    __cmut__qt5__module_to_component__define_relation( "NetworkAuth" "qtnetworkauth" )
    __cmut__qt5__module_to_component__define_relation( "Network" "qtbase" )
    __cmut__qt5__module_to_component__define_relation( "Nfc" "qtconnectivity" )
    __cmut__qt5__module_to_component__define_relation( "OpenGLExtensions" "qtbase" )
    __cmut__qt5__module_to_component__define_relation( "OpenGL" "qtbase" )
    __cmut__qt5__module_to_component__define_relation( "PacketProtocol" "qtdeclarative" )
    __cmut__qt5__module_to_component__define_relation( "PlatformCompositorSupport" "qtbase" )
    __cmut__qt5__module_to_component__define_relation( "Positioning" "qtlocation" )
    __cmut__qt5__module_to_component__define_relation( "PrintSupport" "qtbase" )
    __cmut__qt5__module_to_component__define_relation( "Purchasing" "qtpurchasing" )
    __cmut__qt5__module_to_component__define_relation( "QmlDebug" "qtdeclarative" )
    __cmut__qt5__module_to_component__define_relation( "QmlDevTools" "qtdeclarative" )
    __cmut__qt5__module_to_component__define_relation( "Qml" "qtdeclarative" )
    __cmut__qt5__module_to_component__define_relation( "QuickControls2" "qtquickcontrols2" )
    __cmut__qt5__module_to_component__define_relation( "QuickParticles" "qtdeclarative" )
    __cmut__qt5__module_to_component__define_relation( "Quick" "qtdeclarative" )
    __cmut__qt5__module_to_component__define_relation( "QuickTemplates2" "qtquickcontrols2" )
    __cmut__qt5__module_to_component__define_relation( "QuickTest" "qtdeclarative" )
    __cmut__qt5__module_to_component__define_relation( "QuickWidgets" "qtdeclarative" )
    __cmut__qt5__module_to_component__define_relation( "RemoteObjects" "qtremoteobjects" )
    __cmut__qt5__module_to_component__define_relation( "RepParser" "qtremoteobjects" )
    __cmut__qt5__module_to_component__define_relation( "Script" "qtscript" )
    __cmut__qt5__module_to_component__define_relation( "ScriptTools" "qtscript" )
    __cmut__qt5__module_to_component__define_relation( "Scxml" "qtscxml" )
    __cmut__qt5__module_to_component__define_relation( "Sensors" "qtsensors" )
    __cmut__qt5__module_to_component__define_relation( "SerialBus" "qtserialbus" )
    __cmut__qt5__module_to_component__define_relation( "SerialPort" "qtserialport" )
    __cmut__qt5__module_to_component__define_relation( "ServiceSupport" "qtbase" )
    __cmut__qt5__module_to_component__define_relation( "Sql" "qtbase" )
    __cmut__qt5__module_to_component__define_relation( "Svg" "qtsvg" )
    __cmut__qt5__module_to_component__define_relation( "Test" "qtbase" )
    __cmut__qt5__module_to_component__define_relation( "TextToSpeech" "qtspeech" )
    __cmut__qt5__module_to_component__define_relation( "ThemeSupport" "qtbase" )
    __cmut__qt5__module_to_component__define_relation( "UiPlugin" "qttools" )
    __cmut__qt5__module_to_component__define_relation( "UiTools" "qttools" )
    __cmut__qt5__module_to_component__define_relation( "VulkanSupport" "qtbase" )
    __cmut__qt5__module_to_component__define_relation( "WaylandClient" "qtwayland" )
    __cmut__qt5__module_to_component__define_relation( "WaylandCompositor" "qtwayland" )
    __cmut__qt5__module_to_component__define_relation( "WebChannel" "qtwebchannel" )
    __cmut__qt5__module_to_component__define_relation( "WebEngineCore" "qtwebengine" )
    __cmut__qt5__module_to_component__define_relation( "WebEngine" "qtwebengine" )
    __cmut__qt5__module_to_component__define_relation( "WebEngineWidgets" "qtwebengine" )
    __cmut__qt5__module_to_component__define_relation( "WebSockets" "qtwebsockets" )
    __cmut__qt5__module_to_component__define_relation( "WebView" "qtwebview" )
    __cmut__qt5__module_to_component__define_relation( "Widgets" "qtbase" )
    __cmut__qt5__module_to_component__define_relation( "WinExtras" "qtwinextras" )
    __cmut__qt5__module_to_component__define_relation( "X11Extras" "qtx11extras" )
    __cmut__qt5__module_to_component__define_relation( "XcbQpa" "qtbase" )
    __cmut__qt5__module_to_component__define_relation( "XmlPatterns" "qtxmlpatterns" )
    __cmut__qt5__module_to_component__define_relation( "Xml" "qtbase" )
    __cmut__qt5__module_to_component__define_relation( "Zlib" "qtbase" )

    __cmut__qt5__module_to_component__set_data_defined( 1 )

endfunction()

macro( __cmut__qt5__module_to_component__define_data_if_not_done )

    __cmut__qt5__module_to_component__is_data_defined( defined )
    if( NOT defined )
        __cmut__qt5__module_to_component__define_data()
    endif()

endmacro()

########################################################################################################################
########################################################################################################################
########################################################################################################################

function( cmut__qt5__get_modules_for_component result component )

    __cmut__qt5__module_to_component__define_data_if_not_done()

    get_property( modules GLOBAL PROPERTY CMUT__QT5__COMPONENT_TO_MODULES__${component} )
    set( ${result} ${modules} PARENT_SCOPE )

endfunction()

########################################################################################################################

function( cmut__qt5__get_component_for_module result module )

    __cmut__qt5__module_to_component__define_data_if_not_done()

    get_property( component GLOBAL PROPERTY CMUT__QT5__MODULE_TO_COMPONENT__${module} )

    set( ${result} ${component} PARENT_SCOPE )

endfunction()
