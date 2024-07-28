import { pgTable, varchar, timestamp, uuid, pgEnum } from "drizzle-orm/pg-core";

const statusEnum = pgEnum("status", ["Shipped", "In progress", "Deprecated"]);

export const User = pgTable("user", {
  id: uuid("userId").primaryKey().defaultRandom(),
  created_at: timestamp("created_at").defaultNow(),
  username: varchar("username", { length: 255 }).unique(),
  password: varchar("password", { length: 255 }),
});

export const Product = pgTable("product", {
  id: uuid("id").primaryKey().defaultRandom(),
  created_at: timestamp("created_at").defaultNow(),
  name: varchar("name", { length: 255 }),
  belongsTo: uuid("productId")
    .references(() => User.id)
    .notNull(),
});

export const Update = pgTable("update", {
  id: uuid("updateId").primaryKey().defaultRandom(),
  created_at: timestamp("created_at").defaultNow(),
  updated_at: timestamp("updated_at"),
  title: varchar("title", { length: 255 }),
  status: statusEnum("status").default("In progress"),
  version: varchar("version", { length: 255 }),
  asset: varchar("asset", { length: 255 }),
  belongsTo: uuid("updateId")
    .references(() => Product.id)
    .notNull(),
});

export const UpdatePoint = pgTable("update_point", {
  id: uuid("updatePointId").primaryKey().defaultRandom(),
  created_at: timestamp("created_at").defaultNow(),
  updated_at: timestamp("updated_at"),
  name: varchar("name", { length: 255 }),
  description: varchar("description"),
  belongsTo: uuid("updateId")
    .references(() => Update.id)
    .notNull(),
});
