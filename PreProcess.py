import pandas as pd

data = pd.read_csv('Corona Virus Dataset.csv')

for i in range(len(data['Date'])):
    val = str(data['Date'][i]).split('-')
    new_val = ''
    for j in range(len(val)-1, -1, -1):
        new_val += val[j]
        if j != 0:
            new_val += '-'
    data['Date'][i] = new_val

data.to_csv('CoronaData.csv', index=False)
