CREATE TABLE IF NOT EXISTS "product" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"created_at" timestamp DEFAULT now(),
	"name" varchar(255),
	"productId" uuid NOT NULL
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "update" (
	"updateId" uuid NOT NULL,
	"created_at" timestamp DEFAULT now(),
	"updated_at" timestamp,
	"title" varchar(255),
	"status" "status" DEFAULT 'In progress',
	"version" varchar(255),
	"asset" varchar(255)
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "update_point" (
	"updatePointId" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"created_at" timestamp DEFAULT now(),
	"updated_at" timestamp,
	"name" varchar(255),
	"description" varchar,
	"updateId" uuid NOT NULL
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "user" (
	"userId" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"created_at" timestamp DEFAULT now(),
	"username" varchar(255),
	"password" varchar(255),
	CONSTRAINT "user_username_unique" UNIQUE("username")
);
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "product" ADD CONSTRAINT "product_productId_user_userId_fk" FOREIGN KEY ("productId") REFERENCES "public"."user"("userId") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "update" ADD CONSTRAINT "update_updateId_product_id_fk" FOREIGN KEY ("updateId") REFERENCES "public"."product"("id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "update_point" ADD CONSTRAINT "update_point_updateId_update_updateId_fk" FOREIGN KEY ("updateId") REFERENCES "public"."update"("updateId") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
