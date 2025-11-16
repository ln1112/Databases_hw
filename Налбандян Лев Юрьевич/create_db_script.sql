CREATE TABLE "transactions" (
  "id" serial PRIMARY KEY,
  "product_id" integer not null,
  "customer_id" integer not null,
  "order_id" integer not null,
  "transaction_date" date not null
);

CREATE TABLE "orders" (
  "id" serial PRIMARY KEY,
  "online_order" boolean null,
  "order_status_id" integer not null
);

CREATE TABLE "order_statuses" (
  "id" serial PRIMARY KEY,
  "status" varchar(20) not null
);

CREATE TABLE "products" (
  "id" serial PRIMARY KEY,
  "brand_id" integer null,
  "product_line_id" integer null,
  "product_class_id" integer null,
  "product_size_id" integer null, 
  "list_price" real not null,
  "standard_cost" real null
);

CREATE TABLE "brands" (
  "id" serial PRIMARY KEY,
  "name" varchar(40) not null
);

CREATE TABLE "product_lines" (
  "id" serial PRIMARY KEY,
  "name" varchar(35) not null
);

CREATE TABLE "product_classes" (
  "id" serial PRIMARY KEY,
  "name" varchar(35) not null
);

CREATE TABLE "product_sizes" (
  "id" serial PRIMARY KEY,
  "name" varchar(20) not null
);

CREATE TABLE "customers" (
  "id" serial PRIMARY KEY,
  "first_name"  varchar(35) not null,
  "last_name"  varchar(35) null,
  "data_of_birthday" date null,
  "deceased_indicator" varchar(1) not null, --можно сделать boolean или вынести в справочник
  "property_valuation" integer not null,
  "owns_car" boolean null,
  "gender_id" integer not null,
  "job_info_id" integer not null,
  "address_info_id" integer not null
);

CREATE TABLE "genders" (
  "id" serial PRIMARY KEY,
  "gender" varchar(6) not null
);

CREATE TABLE "job_info" (
  "id" serial PRIMARY KEY,
  "job_title"  varchar(60) null,
  "industry_category_id" integer not null,
  "wealth_segment_id" integer not null
);

CREATE TABLE "industry_categories" (
  "id" serial PRIMARY KEY,
  "name"  varchar(40) not null
);

CREATE TABLE "wealth_segments" (
  "id" serial PRIMARY KEY,
  "name" varchar(40) not null
);

CREATE TABLE "address_info" (
  "id" serial PRIMARY KEY,
  "address" varchar(60) not null,
  "postcode" varchar(60) not null,
  "state_id" integer not null,
  "country_id" integer not null
);

CREATE TABLE "countries" (
  "id" serial PRIMARY KEY,
  "name" varchar(30) not null
);

CREATE TABLE "states" (
  "id" serial PRIMARY KEY,
  "name" varchar(30) not null
);

ALTER TABLE "orders" ADD CONSTRAINT "order_order_statuses" FOREIGN KEY ("order_status_id") REFERENCES "order_statuses" ("id");

ALTER TABLE "products" ADD CONSTRAINT "products_brands" FOREIGN KEY ("brand_id") REFERENCES "brands" ("id");

ALTER TABLE "products" ADD CONSTRAINT "products_product_line_id" FOREIGN KEY ("product_line_id") REFERENCES "product_lines" ("id");

ALTER TABLE "products" ADD CONSTRAINT "products_product_class_id" FOREIGN KEY ("product_class_id") REFERENCES "product_classes" ("id");

ALTER TABLE "products" ADD CONSTRAINT "products_product_size_id" FOREIGN KEY ("product_size_id") REFERENCES "product_sizes" ("id");

ALTER TABLE "transactions" ADD CONSTRAINT "transactions_products" FOREIGN KEY ("product_id") REFERENCES "products" ("id");

ALTER TABLE "transactions" ADD CONSTRAINT "transactions_orders" FOREIGN KEY ("order_id") REFERENCES "orders" ("id");

ALTER TABLE "transactions" ADD CONSTRAINT "transactions_customers" FOREIGN KEY ("customer_id") REFERENCES "customers" ("id");

ALTER TABLE "job_info" ADD CONSTRAINT "job_info_industry_category" FOREIGN KEY ("industry_category_id") REFERENCES "industry_categories" ("id");

ALTER TABLE "job_info" ADD CONSTRAINT "job_info_wealth_segment" FOREIGN KEY ("wealth_segment_id") REFERENCES "wealth_segments" ("id");

ALTER TABLE "customers" ADD CONSTRAINT "customer_gender" FOREIGN KEY ("gender_id") REFERENCES "genders" ("id");

ALTER TABLE "customers" ADD CONSTRAINT "customer_job_info" FOREIGN KEY ("job_info_id") REFERENCES "job_info" ("id");

ALTER TABLE "customers" ADD CONSTRAINT "customer_address_info" FOREIGN KEY ("address_info_id") REFERENCES "address_info" ("id");

ALTER TABLE "address_info" ADD CONSTRAINT "address_info_country" FOREIGN KEY ("country_id") REFERENCES "countries" ("id");

ALTER TABLE "address_info" ADD CONSTRAINT "address_info_state" FOREIGN KEY ("state_id") REFERENCES "states" ("id");