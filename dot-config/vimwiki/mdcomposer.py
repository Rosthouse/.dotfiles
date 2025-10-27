from __future__ import annotations
from typing import List


class Task:
    def __init__(self, content: str, done: bool) -> None:
        self.content: str = content
        self.done: bool = done

    def __str__(self) -> str:
        return f"[{'X' if self.done else ' '}] {self.content}"


class Link:
    def __init__(self, href: str, text: str | None = None) -> None:
        self.href: str = href
        self.text: str | None = text

    def __str__(self) -> str:
        return f"<{self.href}>" if self.text is None else f"[{self.text}]({self.href})"


class Image:
    def __init__(self, src: str, text: str | None = None) -> None:
        self.src: str = src
        self.text: str | None = text


class MdComposer:
    def __init__(self, document: List[str] = [], references: List[str] = []):
        self.document: List[str] = document
        self.references: List[str] = references

    def add_title(self: MdComposer, title: str, level: int) -> MdComposer:
        return MdComposer(self.document + [f"{'#' * level} {title}"], self.references)

    def add_paragraph(self: MdComposer, paragraph: str) -> MdComposer:
        return MdComposer(self.document + [paragraph], self.references)

    def add_block_quote(self: MdComposer, block: str) -> MdComposer:
        return MdComposer(self.document + [f"> {block}"], self.references)

    def add_unordered_list(self: MdComposer, lst: List[str | Task]) -> MdComposer:
        uol = "".join([f"- {str(i)}\n" for i in lst])
        return MdComposer(self.document + [uol], self.references)

    def add_reference(self: MdComposer, ref: str) -> MdComposer:
        return MdComposer(self.document, self.references + [ref])

    def __str__(self: MdComposer) -> str:
        return "".join([f"{x}\n\n" for x in self.document])
