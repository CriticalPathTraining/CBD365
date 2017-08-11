USE [ProductsDB]
GO

DROP TABLE [dbo].[Products]
GO

CREATE TABLE Products(
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](max) NOT NULL,
	[Category] [nvarchar](max) NOT NULL,
	[ListPrice] [float] NOT NULL,
	[Description] [nvarchar](max) NOT NULL,
	[ProductImageUrl] [nvarchar](max) NULL,
 CONSTRAINT [PK.Products] PRIMARY KEY CLUSTERED ([Id] ASC))
GO

INSERT INTO Products([Name],[Category],[ListPrice],[Description],[ProductImageUrl])VALUES('Batman Action Figure', 'Action Figures', 14.95, 'A super hero who sometimes plays the role of a dark knight.', 'WP0001.jpg')
INSERT INTO Products([Name],[Category],[ListPrice],[Description],[ProductImageUrl])VALUES('Captain America Action Figure', 'Action Figures', 12.95, 'A super action figure that protects freedom and the American way of life.', 'WP0002.jpg')
INSERT INTO Products([Name],[Category],[ListPrice],[Description],[ProductImageUrl])VALUES('Easel with Supply Trays', 'Arts and Crafts', 49.95, 'A serious easel for serious young artists.', 'WP0003.jpg')
INSERT INTO Products([Name],[Category],[ListPrice],[Description],[ProductImageUrl])VALUES('Crate o'' Crayons', 'Arts and Crafts', 14.95, 'More crayons that you can shake a stick at.', 'WP0004.jpg')
INSERT INTO Products([Name],[Category],[ListPrice],[Description],[ProductImageUrl])VALUES('Green Stomper Bully', 'Remote Control', 24.95, 'A green alternative to crush and destroy the Red Stomper Bully.', 'WP0005.jpg')
INSERT INTO Products([Name],[Category],[ListPrice],[Description],[ProductImageUrl])VALUES('Indy Race Car', 'Remote Control', 19.95, 'The fastest remote control race car on the market today.', 'WP0006.jpg')
INSERT INTO Products([Name],[Category],[ListPrice],[Description],[ProductImageUrl])VALUES('Twitter Follower Action Figure', 'Action Figures', 1, 'An inexpensive action figure you can never have too many of.', 'WP0007.jpg')
INSERT INTO Products([Name],[Category],[ListPrice],[Description],[ProductImageUrl])VALUES('Sandpiper Prop Plane', 'Remote Control', 24.95, 'A simple RC prop plane for younger pilots.', 'WP0008.jpg')
INSERT INTO Products([Name],[Category],[ListPrice],[Description],[ProductImageUrl])VALUES('Etch A Sketch', 'Arts and Crafts', 12.95, 'A strategic planning tool for the Romney campaign.', 'WP0009.jpg')
INSERT INTO Products([Name],[Category],[ListPrice],[Description],[ProductImageUrl])VALUES('Flying Squirrel', 'Remote Control', 69.95, 'A stealthy remote control plane that flies on the down-low and under the radar.', 'WP0010.jpg')
INSERT INTO Products([Name],[Category],[ListPrice],[Description],[ProductImageUrl])VALUES('FOX News Chopper', 'Remote Control', 29.95, 'A new chopper which can generate new events on demand.', 'WP0011.jpg')
INSERT INTO Products([Name],[Category],[ListPrice],[Description],[ProductImageUrl])VALUES('Godzilla Action Figure', 'Action Figures', 19.95, 'The classic and adorable action figure from those old Japanese movies.', 'WP0012.jpg')
INSERT INTO Products([Name],[Category],[ListPrice],[Description],[ProductImageUrl])VALUES('Perry the Platypus Action Figure', 'Action Figures', 21.95, 'A platypus who plays an overly intelligent detective sleuth on TV.', 'WP0013.jpg')
INSERT INTO Products([Name],[Category],[ListPrice],[Description],[ProductImageUrl])VALUES('Seal Team 6 Helicopter', 'Remote Control', 59.95, 'A serious helicopter that can open up a can of whoop-ass when required.', 'WP0014.jpg')
INSERT INTO Products([Name],[Category],[ListPrice],[Description],[ProductImageUrl])VALUES('Crayloa Crayon Set', 'Arts and Crafts', 2.49, 'A very fun set of crayons in every color.', 'WP0015.jpg')

GO