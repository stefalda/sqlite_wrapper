## 0.0.1

* First release of the library in a complete (?) state.
* Tested under MacOs, iOS, Android

## 0.0.2

* Removed dependency from Flutter for tests
* Tested under Windows (both tests and examples)

## 0.0.3

* Autoremove the stream from the streams array when the subscription is cancelled

## 0.0.4

* Fixed the version call to use the "user_version" instead of the "schema_version"
* Added onCreate and onUpgrade callback to simplify migrations
* Added support for opening multiple databases
* Now the openDB method returns some information about the database

## 0.0.5
* Added assert to throw an error when the database has not been opened yet and you're trying to use it

## 0.0.6
* Added method save to perform an upsert

## 0.0.7
* dbName param can now be null instead of having a default value set in every method call

## 0.0.8
* fixed a warning
