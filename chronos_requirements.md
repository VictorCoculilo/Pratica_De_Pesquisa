Para execução do chronos seguindo o exemplo no github do chronos https://github.com/amazon-science/chronos-forecasting

```sh
apt install -y python3 python3-pip git curl
pip install git+https://github.com/amazon-science/chronos-forecasting.git
pip install pandas
pip install matplotlib
```
para usar o chronos em um codigo python : 

```python
from chronos import ChronosPipeline
```

Para uso do autogluon: https://auto.gluon.ai/dev/tutorials/timeseries/forecasting-chronos.html#
                       https://auto.gluon.ai/dev/install.html
                       
```sh
pip install setuptools wheel
pip install

pip install torch==2.4.1+cpu torchvision==0.19.1+cpu --index-url https://download.pytorch.org/whl/cpu

pip install autogluon.timeseries
```

Instalar o autogluon inteiro esta dando erro no momento.
Warning para essa versao do torch. 
Para importar: 

```python
from autogluon.timeseries import TimeSeriesDataFrame, TimeSeriesPredictor
```