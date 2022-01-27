

from sklearn.preprocessing import StandardScaler
import pandas as pd
from keras.models import Model, Sequential, load_model
from keras.layers import *
from keras.callbacks import EarlyStopping, ModelCheckpoint
from keras import applications, optimizers


data_path = "/Users/jamescutler/Desktop/Data_Course_cutler/Imputation_MICE/Chen_scripts/01_method_exploration/00_try_out_stuff/00_python_data/equation_3/round_2/"
# i = 1
for j in range(200):
    i = j + 1
    full_path = data_path + "datB_" + str(i) + ".csv"
    dat2 = pd.read_csv(full_path)

    # Data needs to be scaled to a small range like 0 to 1 for the neural
    # network to work well.
    scaler = StandardScaler()

    X = dat2.drop('syB', axis=1).values
    ncol = X.shape[1]
    Y = dat2[['syB']].values
    scaler.fit(Y)
    Y_scaled = scaler.transform(Y)
    # Y
    # scaler.inverse_transform(Y_scaled)

    # Scale both the training inputs and outputs
    # scaled_training = scaler.fit_transform(training_data_df)
    # scaled_testing = scaler.transform(test_data_df)


    # Define the model
    # ADD / SUBTRACT number of layers (try 3, 4, 5 output included)
    model = Sequential()
    model.add(Dense(50, input_dim=ncol, activation='relu'))
    model.add(Dense(50, activation='relu'))
    model.add(Dense(50, activation='relu'))
    model.add(Dense(50, activation='relu'))
    model.add(Dense(1, activation='linear'))

    # Change learning rate each time (range: .1, .01, .001, .0001, .00001, .000001)
    learning_rate = .01

    opt = optimizers.Adam(learning_rate = learning_rate)

    # Compile model
    model.compile(loss='mean_squared_error', optimizer=opt, metrics=['mse'])

    es = EarlyStopping(monitor='val_loss', mode='min', verbose=1, patience=15)
    mc = ModelCheckpoint('best_model.h5', monitor='val_loss', mode='min', verbose=1, save_best_only=True)

    # Train the model
    model.fit(
        X,
        Y_scaled,
        batch_size = 32,
        validation_split = .25,
        epochs = 50,
        shuffle = True,
        callbacks = [es, mc],
        verbose = 2
    )

    # Call model
    saved_model = load_model('best_model.h5')

    # Extract Y hats from saved_model
    full_A_path = data_path + "datXA_" + str(i) + ".csv"
    test_data = pd.read_csv(full_A_path)
    Xt = test_data
    Yp = saved_model.predict(Xt)
    Yp_unscaled = scaler.inverse_transform(Yp)

    # Export as CSV
    full_pred_path = data_path + "5_pred_" + str(i) + ".csv"
    df_Yp_unscaled = pd.DataFrame(data=Yp_unscaled)
    df_Yp_unscaled.to_csv(full_pred_path,index=False)
