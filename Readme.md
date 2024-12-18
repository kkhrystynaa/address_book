
Link: https://crates.io/crates/address_book Docs: https://docs.rs/address_book/0.3.0/address_book/
#Тема: address book - адресна книга

# Парсер телефонних номерів та полів

Цей проєкт надає інструмент командного рядка для парсингу серії телефонних номерів, ідентифікаторів, дат і неправильних полів. Інструмент створено за допомогою мови програмування Rust і бібліотеки парсингу `pest`. Вхідні дані можуть містити телефонні номери у форматі `XXX-XXX-XXXX`, ідентифікатори з мінімум 5 алфавітно-цифрових символів і дати у форматі `YYYY-MM-DD`, а також можливі неправильні поля. Парсер також підтримує коментарі, які ігноруються під час парсингу.

## Процес парсингу

Процес парсингу передбачає обробку рядка даних, що містить поля, розділені комами. Кожне поле може бути одним з наступних:
- **Телефонний номер**: рядок формату `XXX-XXX-XXXX` (3 цифри, дефіс, 3 цифри, дефіс, 4 цифри).
- **Ідентифікатор**: рядок з мінімум 5 алфавітно-цифрових символів.
- **Дата**: рядок формату `YYYY-MM-DD`.
- **Неправильні поля**: будь-який рядок, що не відповідає жодному з вищезазначених форматів, вважається неправильним.
- **Коментарі**: рядки або частини рядків, що починаються з `#`, вважаються коментарями і ігноруються під час парсингу.

### Як працює парсинг:
1. Парсер обробляє вхідний рядок і намагається зіставити кожне поле з визначеними форматами.
2. Валідні поля збираються у список допустимих записів (наприклад, телефонні номери, ідентифікатори, дати).
3. Неправильні поля відокремлюються в окремий список для подальшої обробки чи звітності.
4. Коментарі ігноруються під час парсингу.

### Використання

Ви можете використовувати інструмент командного рядка для парсингу файлу, що містить серію телефонних номерів, ідентифікаторів і дат, а також для обробки неправильних полів і коментарів.

## Граматика для парсингу полів

Граматика, що використовується для парсингу полів, складається з наступних правил:

- **`fields`**: Послідовність полів, розділених комами, з можливими пробілами та коментарями.
    ```
    fields = {
        (field | invalid_field) ~
        (whitespace? ~ "," ~ whitespace? ~ (field | invalid_field))*
        ~ (whitespace? ~ comment)?
    }
    ```

- **`field`**: Поле може бути номером телефону, ідентифікатором або датою.
    ```
    field = { phone_number | identifier | date }
    ```

- **`phone_number`**: Номер телефону у форматі `XXX-XXX-XXXX`.
    ```
    phone_number = { ASCII_DIGIT{3} ~ "-" ~ ASCII_DIGIT{3} ~ "-" ~ ASCII_DIGIT{4} }
    ```

- **`identifier`**: Ідентифікатор, що складається мінімум з 5 алфавітно-цифрових символів.
    ```
    identifier = { ASCII_ALPHANUMERIC{5,} }
    ```

- **`date`**: Дата у форматі `YYYY-MM-DD`.
    ```
    date = { ASCII_DIGIT{4} ~ "-" ~ ASCII_DIGIT{2} ~ "-" ~ ASCII_DIGIT{2} }
    ```

- **`invalid_field`**: Невірне поле, яке не відповідає жодному з вищезгаданих форматів.
    ```
    invalid_field = { (!phone_number ~ !identifier ~ !date ~ (!"," ~ ANY)+) }
    ```

- **`comment`**: Коментар, що починається з `#` і ігнорується під час парсингу.
    ```
    comment = { "#" ~ (!"\n" ~ ANY)* }

- **`url`**: URL, що починається з http:// та містить домен і шлях, наприклад, http://example.com/path/to/resource.
   ```
   url = { "http" ~ "://" ~ (ASCII_ALPHANUMERIC+ ~ "." ~ ASCII_ALPHANUMERIC+)+ ~ ("/" ~ ASCII_ALPHANUMERIC*)* }
   ```
- **`email`**: Адреса електронної пошти у форматі user@example.com.
   ```
   email = { ASCII_ALPHANUMERIC+ ~ "@" ~ ASCII_ALPHANUMERIC+ ~ "." ~ ASCII_ALPHANUMERIC+ }
   ```