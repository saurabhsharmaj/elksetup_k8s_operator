import pandas as pd
from xgboost import XGBRanker

df = pd.read_csv("..\\training_features.csv")

X = df[
    [
        "bm25",
        "rating",
        "sales",
        "ctr",
        "conversion"
    ]
]

y = df["label"]

group = df.groupby("query").size().to_numpy()

model = XGBRanker(
    objective="rank:ndcg",
    learning_rate=0.1,
    max_depth=4,
    n_estimators=100
)

model.fit(X, y, group=group)
model.save_model("ltr.json")