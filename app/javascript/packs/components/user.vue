<template>
  <v-data-table
    :headers="headers"
    :items="desserts"
    :search="search"
    sort-by="first_name"
    class="elevation-1"
  >
    <template v-slot:top>
      <v-toolbar flat color="white">
        <v-toolbar-title>My App!</v-toolbar-title>
        <v-spacer></v-spacer>
        <v-text-field
          v-model="search"
          append-icon="mdi-magnify"
          label="Search"
          single-line
          hide-details
          color="rgb(231,140,145)"
        ></v-text-field>
        <v-divider class="mx-4" inset vertical></v-divider>
        <v-spacer></v-spacer>
        <v-dialog v-model="dialog" max-width="500px">
          <template v-slot:activator="{ on }">
            <v-btn color="rgb(231,140,145)" dark class="mb-2" v-on="on"
              >New Item</v-btn
            >
          </template>
          <v-card>
            <v-card-title>
              <span class="headline">{{ formTitle }}</span>
            </v-card-title>

            <v-card-text>
              <v-container>
                <v-row>
                  <v-col cols="12" sm="6" md="4">
                    <v-text-field
                      v-model="editedItem.first_name"
                      label="First Name"
                    ></v-text-field>
                  </v-col>
                  <v-col cols="12" sm="6" md="4">
                    <v-text-field
                      v-model="editedItem.last_name"
                      label="Last Name"
                    ></v-text-field>
                  </v-col>
                  <v-col cols="12" sm="6" md="4">
                    <v-text-field
                      v-model="editedItem.email"
                      label="Email"
                    ></v-text-field>
                  </v-col>
                  <v-col cols="12" sm="6" md="4">
                    <v-text-field
                      v-model="editedItem.phone"
                      label="Phone"
                    ></v-text-field>
                  </v-col>
                  <v-col cols="12" sm="6" md="4">
                    <v-text-field
                      v-model="editedItem.task"
                      label="Task"
                    ></v-text-field>
                  </v-col>
                </v-row>
              </v-container>
            </v-card-text>

            <v-card-actions>
              <v-spacer></v-spacer>
              <v-btn color="blue darken-1" text @click="close">Cancel</v-btn>
              <v-btn color="blue darken-1" text @click="validate(editedItem)"
                >Save</v-btn
              >
            </v-card-actions>
          </v-card>
        </v-dialog>
      </v-toolbar>
    </template>
    <template v-slot:item.action="{ item }">
      <v-icon small class="mr-2" @click="editItem(item)">edit</v-icon>
      <v-icon small @click="deleteItem(item)">delete</v-icon>
    </template>
    <template v-slot:no-data>
      <v-btn color="primary" @click="initialize">Reset</v-btn>
    </template>
  </v-data-table>
</template>

<script>
import axios from "axios";
export default {
  data: () => ({
    search: "",
    dialog: false,
    headers: [
      {
        text: "First Name",
        align: "left",
        sortable: false,
        value: "first_name",
      },
      { text: "Last Name", value: "last_name" },
      { text: "Email", value: "email" },
      { text: "Phone", value: "phone" },
      { text: "Task", value: "task" },
      { text: "Actions", value: "action", sortable: false },
    ],
    desserts: [],
    editedIndex: -1,
    editedItem: {
      first_name: "",
      last_name: "",
      email: "",
      phone: "",
      task: "",
    },
    defaultItem: {
      first_name: "",
      last_name: "",
      email: "",
      phone: "",
      task: "",
    },
  }),
  computed: {
    formTitle() {
      return this.editedIndex === -1 ? "New Item" : "Edit Item";
    },
  },
  watch: {
    dialog(val) {
      val || this.close();
    },
  },
  created() {
    this.initialize();
  },
  methods: {
    initialize() {
      return axios
        .get("http://localhost:3000/users")
        .then((response) => {
          console.log(response.data);
          this.desserts = response.data;
        })
        .catch((e) => {
          console.log(e);
        });
    },
    editItem(item) {
      this.editedIndex = item.id;
      this.editedItem = Object.assign({}, item);
      this.dialog = true;
    },
    deleteItem(item) {
      const index = this.desserts.indexOf(item);
      confirm("Are you sure you want to delete this item?");
      axios
        .delete(`http://localhost:3000/users/${item.id}`)
        .then((response) => {
          console.log(response);
          console.log(response.data.json);
          alert(response.data.json);
          this.initialize();
        })
        .catch((error) => {
          console.log(error);
        });
      this.desserts.splice(index, 1);
    },
    close() {
      this.dialog = false;
      setTimeout(() => {
        this.editedItem = Object.assign({}, this.defaultItem);
        this.editedIndex = -1;
      }, 300);
    },
    validate(editedItem) {
      function emailIsValid(email) {
        return /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/.test(
          email
        );
      }
      switch (true) {
        case !this.editedItem.first_name:
          alert("First name required!");
          break;
        case !this.editedItem.last_name:
          alert("Last name required!");
          break;
        case !this.editedItem.email:
          alert("Email required!");
          break;
        case !this.editedItem.phone:
          alert("Phone number required!");
          break;
        case !this.editedItem.task:
          alert("Task required!");
          break;
        case isNaN(this.editedItem.phone) ||
          this.editedItem.phone < 10 ||
          this.editedItem.phone < 12:
          alert("Phone number must be valid!");
          break;
        case !this.editedItem.task:
          alert("Task required!");
          break;
        case !emailIsValid(this.editedItem.email):
          alert("Proper email require!");
          break;
        default:
          this.save(editedItem);
      }
    },
    save(item) {
      if (this.editedIndex > -1) {
        axios
          .put(`http://localhost:3000/users/${item.id}`, {
            id: this.editedItem.id,
            first_name: this.editedItem.first_name,
            last_name: this.editedItem.last_name,
            email: this.editedItem.email,
            phone: this.editedItem.phone,
            task: this.editedItem.task,
          })
          .then((response) => {
            console.log(response);
            this.initialize();
          })
          .catch((error) => {
            console.log(error);
          });
      } else {
        console.log(item);
        axios
          .post(`http://localhost:3000/users/`, {
            user: this.editedItem,
          })
          .then((response) => {
            console.log(response);
            console.log("Created!");
            this.initialize();
          })
          .catch((error) => {
            console.log(error);
          });
        this.desserts.push(this.editedItem);
      }
      this.close();
    },
    getUser(item) {
      axios
        .get(`http://localhost:3000/${item.id}`)
        .then((response) => {
          this.dessert = response.data;
        })
        .catch((error) => {
          console.log(error);
        });
    },
  },
};
</script>
