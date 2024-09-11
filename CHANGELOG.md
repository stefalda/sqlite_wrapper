## 0.1.2
* Fixed some dependencies,lint problems and compiled with latest Flutter version
* Updated sqlite version dependency and sdk constraint

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

## 0.0.9
* create the parent folders of the DB file if they are missing

## 0.1.0
* created a parent class SQLiteWrapperCore that can be instantiated/subclassed and used instead of the Singleton implementation

## 0.1.1
* the method updateStreams is now public to be able to force externally a refresh of one or more data streams

## 0.1.3
* bug fix for update and delete not working with tables having multiple primary keys

## 0.2.0-dev-1
* added support for flutter web
* new lint rules
* added CI pipeline
* review of class structures

## 0.2.0
* bumped sqflite_common_ffi_web to latest version

## 0.2.1
* exported isRunningOnWeb from platform

## 0.2.2
* code reorganization and introduction of factory method getInstance
