import sys
import subprocess
import os
from json_editor import JSONEditor

def get_git_config(key: str) -> str:
    try:
        result = subprocess.run(['git', 'config', '--global', key], capture_output=True, text=True, check=True)
        return result.stdout.strip()
    except subprocess.CalledProcessError:
        return ""

def main():
    if len(sys.argv) < 3:
        print("Usage: python setup_project.py <path_to_package_json> <project_name>")
        sys.exit(1)
        
    package_json_path = sys.argv[1]
    project_name = sys.argv[2]
    
    # Load git configs
    author_name = get_git_config('user.name')
    author_email = get_git_config('user.email')
    author_url = get_git_config('user.url')
    
    editor = JSONEditor(package_json_path)
    
    # Update project name (since we are creating the project)
    editor.root().set('name', project_name)
    
    # Build author object
    author = {}
    if author_name:
        author['name'] = author_name
    if author_email:
        author['email'] = author_email
    if author_url:
        author['url'] = author_url
        
    if author:
        editor.root().set('author', author)
        
    editor.save(indent=2)
    print(f"Updated package.json with project name and author info.")

if __name__ == "__main__":
    main()
