package controller;

import dao.OwnerDao;
import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import javafx.fxml.FXML;
import javafx.scene.control.Label;
import javafx.scene.control.TableColumn;
import javafx.scene.control.TableView;
import javafx.scene.control.cell.PropertyValueFactory;
import javafx.scene.layout.AnchorPane;
import javafx.stage.Stage;
import main.MainApp;
import model.Booking;
import model.Hotel;

import java.sql.Date;
import java.util.ArrayList;

public class OwnerController {
    @FXML
    private AnchorPane anchorPane;
    @FXML
    private Label ownerNameLabel;

    @FXML
    private TableView<Hotel> hotelTable;
    @FXML
    private TableColumn<Hotel, String> hotelNameColumn;
    @FXML
    private TableColumn<Hotel, String> hotelDescColumn;
    @FXML
    private TableColumn<Hotel, Integer> roomsQuantityColumn;
    @FXML
    private TableColumn<Hotel, String> hotelCityColumn;
    @FXML
    private ObservableList<Hotel> hotelData;
    private ArrayList<Hotel> hotels;

    @FXML
    private TableView<Booking> bookingTable;
    @FXML
    private TableColumn<Booking, String> hotelBookNameColumn;
    @FXML
    private TableColumn<Booking, Integer> roomIdColumn;
    @FXML
    private TableColumn<Booking, Date> dateInColumn;
    @FXML
    private TableColumn<Booking, Date> dateOutColumn;
    @FXML
    private TableColumn<Booking, Integer> priceBookingColumn;
    private ObservableList<Booking> bookingData;

    private Stage dialogStage;
    private MainApp mainApp;
    private OwnerDao ownerDao;
    private ArrayList<Booking> bookings;

    @FXML
    public void initialize() {
        ownerDao = new OwnerDao();

        hotelData = FXCollections.observableArrayList();
        hotelNameColumn.setCellValueFactory(new PropertyValueFactory<>("hotelName"));
        hotelDescColumn.setCellValueFactory(new PropertyValueFactory<>("hotelDescription"));
        roomsQuantityColumn.setCellValueFactory(new PropertyValueFactory<>("roomsQuantity"));
        hotelCityColumn.setCellValueFactory(new PropertyValueFactory<>("city"));

        bookingData = FXCollections.observableArrayList();
        hotelBookNameColumn.setCellValueFactory(new PropertyValueFactory<>("hotelName"));
        roomIdColumn.setCellValueFactory(new PropertyValueFactory<>("roomId"));
        dateInColumn.setCellValueFactory(new PropertyValueFactory<>("dateIn"));
        dateOutColumn.setCellValueFactory(new PropertyValueFactory<>("dateOut"));
        priceBookingColumn.setCellValueFactory(new PropertyValueFactory<>("price"));
    }

    public void setMainApp(MainApp mainApp) {
        this.mainApp = mainApp;
    }

    public void setOwnerNameLabel(String name) {
        ownerNameLabel.setText(name);
    }

    @FXML
    private void handleHotelRefreshButton() {
        hotelData.clear();
        hotelTable.setItems(hotelData);

        hotels = ownerDao.retrieveHotels(ownerNameLabel.getText());

        if (hotels != null) {
            for (Hotel hotel : hotels) {
                hotelData.add(hotel);
            }

            hotelTable.setItems(hotelData);
        }
    }

    @FXML
    private void handleAddHotelButton() {
        mainApp.showAddHotelPage(ownerNameLabel.getText());
    }

    @FXML
    private void handleAddRoomButton() {
        mainApp.showAddRoomPage(ownerNameLabel.getText());
    }

    @FXML
    private void handleBookingRefreshButton() {
        bookingData.clear();
        bookingTable.setItems(bookingData);
        bookings = ownerDao.retrieveBookings(ownerNameLabel.getText());

        if (bookings != null) {
            for (Booking booking : bookings) {
                bookingData.add(booking);
            }
            bookingTable.setItems(bookingData);
        }
    }

    @FXML
    private void handleSignOutButton() {
        dialogStage = (Stage) anchorPane.getScene().getWindow();
        dialogStage.close();

        mainApp.showLoginPage();
    }
}
