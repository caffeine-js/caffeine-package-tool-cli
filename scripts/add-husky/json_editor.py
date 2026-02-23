import json
import os
from typing import Any, List, Union

class JSONEditor:
    def __init__(self, file_path: str):
        self.file_path = file_path
        self.data = self._load()
        self.cursor = self.data
        self.stack = []

    def _load(self) -> dict:
        if os.path.exists(self.file_path):
            try:
                with open(self.file_path, 'r', encoding='utf-8') as f:
                    return json.load(f)
            except (json.JSONDecodeError, IOError):
                return {}
        return {}

    def at(self, path: str) -> 'JSONEditor':
        keys = path.split('.')
        for key in keys:
            if key not in self.cursor or not isinstance(self.cursor[key], dict):
                self.cursor[key] = {}
            
            self.stack.append((self.cursor, key))
            self.cursor = self.cursor[key]
        return self

    def set(self, key: str, value: Any) -> 'JSONEditor':
        self.cursor[key] = value
        return self

    def back(self) -> 'JSONEditor':
        if self.stack:
            self.cursor, _ = self.stack.pop()
        return self

    def root(self) -> 'JSONEditor':
        self.cursor = self.data
        self.stack = []
        return self

    def get_current(self) -> Any:
        return self.cursor

    def save(self, indent: int = 4) -> None:
        os.makedirs(os.path.dirname(os.path.abspath(self.file_path)), exist_ok=True)
        with open(self.file_path, 'w', encoding='utf-8') as f:
            json.dump(self.data, f, indent=indent, ensure_ascii=False)
