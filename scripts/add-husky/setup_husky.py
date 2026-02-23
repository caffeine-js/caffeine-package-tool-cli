from json_editor import JSONEditor
import os

def setup_husky():
    package_json_path = "package.json"
    
    editor = JSONEditor(package_json_path)
    
    editor.at("scripts").set("prepare", "husky")
    
    editor.root().at("devDependencies")
    editor.set("@commitlint/cli", "^20.4.1")
    editor.set("@commitlint/config-conventional", "^20.4.1")
    editor.set("husky", "^9.1.7")
    
    editor.save()
    print(f"Successfully updated {package_json_path}")

if __name__ == "__main__":
    setup_husky()
