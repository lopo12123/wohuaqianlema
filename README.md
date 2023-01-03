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