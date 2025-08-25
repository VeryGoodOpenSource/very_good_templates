cmake_minimum_required(VERSION 3.13)
project(runner LANGUAGES CXX)

add_executable(${BINARY_NAME}
  "main.cc"
  "application.cc"
  "${FLUTTER_MANAGED_DIR}/generated_plugin_registrant.cc"
)
apply_standard_settings(${BINARY_NAME})
add_definitions(-DAPPLICATION_ID="${APPLICATION_ID}")
target_link_libraries(${BINARY_NAME} PRIVATE flutter)
target_link_libraries(${BINARY_NAME} PRIVATE PkgConfig::GTK)
target_include_directories(${BINARY_NAME} PRIVATE "${CMAKE_SOURCE_DIR}")



https://github.com/waqas028/Document_Scanner_CMP

https://github.com/Coding-Meet/TextToSpeech-CMP

https://github.com/Debanshu777/XCalendar

https://github.com/thejohnsondev/PassGuard-Multiplatform

https://github.com/pksunny/flutter-ui-and-animations