### awesome libs

时间轴展示 https://pub.dev/packages/timeline_tile  
dialog https://pub.dev/packages/panara_dialogs  
dialog https://pub.dev/packages/awesome_dialog  
动态 radial 菜单 https://pub.dev/packages/animated_radial_menu  
环形图/饼图 https://pub.dev/packages/awesome_circular_chart  
navbar https://pub.dev/packages/sliding_clipped_nav_bar  
点击交互菜单 https://pub.dev/packages/pie_menu  
speed_dial https://pub.dev/packages/simple_speed_dial  
底部弹出 https://pub.dev/packages/modal_bottom_sheet

数据库表设计

### records

| 字段       | 数据类型      | 描述                  |
|----------|-----------|---------------------|
| id       | INTEGER   | 主键                  |
| inout    | INTEGER   | 0 支出 / 1 收入         |
| amount   | REAL      | 金额                  |
| method   | Text(10)  | 方式 (可自定义文本标签)       |
| dateTime | Text(20)  | 日期 YYYY-MM-DD_HH:mm |
| desc     | Text(100) | 记录描述                |