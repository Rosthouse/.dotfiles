from mdcomposer import MdComposer, Task

composer = (
    MdComposer()
    .add_title("Test", 1)
    .add_paragraph("This is a simple paragraph")
    .add_title("Second Title", 2)
    .add_unordered_list(["Point1", "Point2"])
    .add_unordered_list([Task("Test", True), Task("TEst2", False)])
)

print(composer)
