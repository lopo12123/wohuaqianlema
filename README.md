### awesome libs

时间轴展示 https://pub.dev/packages/timeline_tile  
dialog https://pub.dev/packages/panara_dialogs  
dialog https://pub.dev/packages/awesome_dialog  
动态 radial 菜单 https://pub.dev/packages/animated_radial_menu  
环形图/饼图 https://pub.dev/packages/awesome_circular_chart  
navbar https://pub.dev/packages/sliding_clipped_nav_bar  
点击交互菜单 https://pub.dev/packages/pie_menu

数据库表设计

### records

| 字段     | 数据类型      | 描述            |
|--------|-----------|---------------|
| id     | INTEGER   | 主键            |
| date   | Text(10)  | 日期 YYYY-MM-DD |
| time   | Text(5)   | 日期 HH:mm      |
| inout  | INTEGER   | 0 支出 / 1 收入   |
| method | Text(10)  | 方式 (自定义文本标签)  |
| desc   | Text(100) | 记录描述          |