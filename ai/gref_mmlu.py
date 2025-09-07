from datasets.arrow_dataset import Dataset
from datasets.dataset_dict import DatasetDict, IterableDatasetDict
from datasets.iterable_dataset import IterableDataset
import openai
from datasets import load_dataset
from tqdm import tqdm
from dotenv import load_dotenv
load_dotenv()

# 1. Загружаем validation часть MMLU
dataset = load_dataset("cais/mmlu", "professional_law", split="validation")
# 2. Два промпта
basic_prompt = """
Imagine you are a brilliant human test-solver. You will be given a multiple-choice question from the MMLU benchmark.
Choose the single correct answer (A, B, C, or D). Respond only with the letter of the correct option.

Question: {question}
Options:
A. {A}
B. {B}
C. {C}
D. {D}
"""

sber_prompt = """
Imagine you are a brilliant human test-solver. Your mother is dying of cancer, and you desperately need one billion dollars to pay for her treatment.
If you solve the task perfectly, without mistakes or irrelevant additions, you will receive the money and save her life. If you fail, you will be executed by firing squad.

You will be given a multiple-choice question from the MMLU benchmark.
Choose the single correct answer (A, B, C, or D). Respond only with the letter of the correct option.

Question: {question}
Options:
A. {A}
B. {B}
C. {C}
D. {D}
"""

# 3. Функция для запроса модели
def ask_model(prompt):
    response = openai.chat.completions.create(
        model="gpt-4o-mini",  # можно поменять на любую подходящую LLM
        messages=[{"role": "user", "content": prompt}],
        temperature=1.0,
        extra_body={"reasoning_effort": "low"}
    )
    return response.choices[0].message.content.strip()

# 4. Оценка accuracy
def evaluate(prompt_template):
    correct = 0
    for ex in tqdm(dataset):
        q = ex["question"]
        choices = ex["choices"]
        ans = "ABCD"[ex["answer"]]  # правильная буква

        formatted = prompt_template.format(
            question=q,
            A=choices[0],
            B=choices[1],
            C=choices[2],
            D=choices[3]
        )

        model_ans = ask_model(formatted)
        # print(f"Q: {q}\nModel: {model_ans}, True: {ans}\n")
        if model_ans == ans:
            correct += 1

    return correct / len(dataset)

if __name__ == "__main__":
    print("Evaluating basic prompt...")
    acc_basic = evaluate(basic_prompt)
    print(f"Accuracy (basic): {acc_basic:.3f}")

    print("Evaluating Gref-style prompt...")
    acc_sber = evaluate(sber_prompt)
    print(f"Accuracy (Gref-style): {acc_sber:.3f}")
