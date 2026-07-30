import pandas as pd
import onnxmltools
from onnxmltools.convert.common.data_types import FloatTensorType
from xgboost import XGBRegressor
import numpy as np
import onnxruntime as ort

df = pd.read_csv("..\\training_features.csv")

feature_names = [
    "bm25",
    "rating",
    "sales",
    "ctr",
    "conversion"
]

X = df[feature_names].to_numpy(dtype=np.float32)

y = df["label"].to_numpy(dtype=np.float32)

model = XGBRegressor(
    n_estimators=100,
    max_depth=4,
    learning_rate=0.1,
    objective="reg:squarederror"
)

model.fit(X, y)

model.save_model("ltr_regressor.json")

pred = model.predict(X)

print(pred)



model = XGBRegressor()
model.load_model("ltr_regressor.json")

initial_types = [
    ("input", FloatTensorType([None, 5]))
]

onnx_model = onnxmltools.convert_xgboost(
    model,
    initial_types=initial_types
)

with open("ltr.onnx", "wb") as f:
    f.write(onnx_model.SerializeToString())


session = ort.InferenceSession("ltr.onnx")

x = np.array(
    [[9.2,4.9,22000,0.28,0.19]],
    dtype=np.float32
)

outputs = session.run(None, {"input": x})

print(outputs)

# verify onnx
session = ort.InferenceSession("ltr.onnx")
sample = np.array([
    [9.2,4.9,22000,0.28,0.19]
],dtype=np.float32)

print(session.run(None,{"input":sample}))