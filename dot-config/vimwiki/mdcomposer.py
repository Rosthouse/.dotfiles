from __future__ import annotations
from typing import List


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

    def add_unordered_list(self: MdComposer, lst: List[str]) -> MdComposer:
        uol = "".join([f"- {i}\n" for i in lst])
        return MdComposer(self.document + [uol], self.references)

    def add_reference_(self: MdComposer, ref: str) -> MdComposer:
        return MdComposer(self.document, self.references + [ref])

    def __str__(self: MdComposer) -> str:
        return "".join([f"{x}\n" for x in self.document])
