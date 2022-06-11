-- CreateEnum
CREATE TYPE "Role" AS ENUM ('ADMIN', 'KNIGHT', 'HERO');

-- CreateTable
CREATE TABLE "User" (
    "id" SERIAL NOT NULL,
    "email" TEXT NOT NULL,
    "name" TEXT,
    "role" "Role" NOT NULL DEFAULT E'KNIGHT',

    CONSTRAINT "User_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Quest" (
    "id" SERIAL NOT NULL,
    "name" TEXT,
    "userId" INTEGER NOT NULL,

    CONSTRAINT "Quest_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "AmbassadorProfile" (
    "id" SERIAL NOT NULL,
    "name" TEXT,
    "userId" INTEGER NOT NULL,
    "questId" INTEGER NOT NULL,
    "twitter" TEXT NOT NULL,
    "profileImage" TEXT NOT NULL,

    CONSTRAINT "AmbassadorProfile_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Hero" (
    "id" SERIAL NOT NULL,
    "name" TEXT,
    "questId" INTEGER NOT NULL,

    CONSTRAINT "Hero_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "_AmbassadorProfileToQuest" (
    "A" INTEGER NOT NULL,
    "B" INTEGER NOT NULL
);

-- CreateTable
CREATE TABLE "_HeroToQuest" (
    "A" INTEGER NOT NULL,
    "B" INTEGER NOT NULL
);

-- CreateIndex
CREATE UNIQUE INDEX "User_email_key" ON "User"("email");

-- CreateIndex
CREATE UNIQUE INDEX "AmbassadorProfile_userId_key" ON "AmbassadorProfile"("userId");

-- CreateIndex
CREATE UNIQUE INDEX "_AmbassadorProfileToQuest_AB_unique" ON "_AmbassadorProfileToQuest"("A", "B");

-- CreateIndex
CREATE INDEX "_AmbassadorProfileToQuest_B_index" ON "_AmbassadorProfileToQuest"("B");

-- CreateIndex
CREATE UNIQUE INDEX "_HeroToQuest_AB_unique" ON "_HeroToQuest"("A", "B");

-- CreateIndex
CREATE INDEX "_HeroToQuest_B_index" ON "_HeroToQuest"("B");

-- AddForeignKey
ALTER TABLE "Quest" ADD CONSTRAINT "Quest_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "AmbassadorProfile" ADD CONSTRAINT "AmbassadorProfile_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_AmbassadorProfileToQuest" ADD CONSTRAINT "_AmbassadorProfileToQuest_A_fkey" FOREIGN KEY ("A") REFERENCES "AmbassadorProfile"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_AmbassadorProfileToQuest" ADD CONSTRAINT "_AmbassadorProfileToQuest_B_fkey" FOREIGN KEY ("B") REFERENCES "Quest"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_HeroToQuest" ADD CONSTRAINT "_HeroToQuest_A_fkey" FOREIGN KEY ("A") REFERENCES "Hero"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_HeroToQuest" ADD CONSTRAINT "_HeroToQuest_B_fkey" FOREIGN KEY ("B") REFERENCES "Quest"("id") ON DELETE CASCADE ON UPDATE CASCADE;
