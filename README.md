# 概要

このプロジェクトは、Reactを使う際に複数のAltJS(TypeScript & Coffee-React & Babel)を混在させるサンプルアプリケーションです。
AltJSを中間ファイルであるjsへと吐きだし、Browserifyでbundleファイルを生成して実行しています。

## 各AltJSのReact対応について

**※リンク先はgulp用のプラグイン**

- [TypeScript](https://www.npmjs.com/package/gulp-typescript)
	- jsx構文を使えるトランスパイラがまだ無い為、[react-jade](https://github.com/jadejs/react-jade)を利用してHTMLタグを記述しています。  
	  react-jadeのコードはBrowserifyでbundle時にreact-jadeプラグインによりES5のJSへとtransformされています。
- CoffeeScript
	- jsx構文をサポートしたCoffeeScriptである[coffee-react](https://www.npmjs.com/package/gulp-coffee-react)を利用
- [Babel](https://www.npmjs.com/package/gulp-babel)
	- jsx構文が標準でサポートされています

## Usage

1. npm install
2. tsd update -s
3. gulp (build | clean)

## Licence

MIT
