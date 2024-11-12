import matplotlib.pyplot as plt
from autogluon.timeseries import TimeSeriesDataFrame, TimeSeriesPredictor

data = TimeSeriesDataFrame(
    "https://autogluon.s3.amazonaws.com/datasets/timeseries/m4_hourly_tiny/train.csv"
)
data.head()

prediction_length = 24
train_data, test_data = data.train_test_split(prediction_length)

predictor = TimeSeriesPredictor(prediction_length=prediction_length).fit(
    train_data, presets="chronos_tiny",
)

predictions = predictor.predict(train_data)
fig2=predictor.plot(
    data=data, 
    predictions=predictions, 
    item_ids=["H1", "H2"],
    max_history_length=200,
)

plt.savefig("figura2.png")
