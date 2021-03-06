{-# LANGUAGE OverloadedStrings #-}
module WikiTest
    ( wikiSpecs
    ) where

import TestImport

wikiSpecs :: Spec
wikiSpecs =
    ydescribe "wiki" $ do

        yit "creates a new page" $ [marked|

            login

            get $ NewWikiR "snowdrift" "testpage"
            statusIs 200

            request $ do
                addNonce
                setUrl $ NewWikiR "snowdrift" "testpage"
                setMethod "POST"
                byLabel "Page Content" "test"
                addPostParam "mode" "preview"

            statusIs 200

            request $ do
                addNonce
                setUrl $ NewWikiR "snowdrift" "testpage"
                setMethod "POST"
                byLabel "Page Content" "test"
                addPostParam "mode" "post"

            statusIs 302

        |]

        yit "edits a wiki page" $ [marked|

            login

            get $ EditWikiR "snowdrift" "testpage"
            statusIs 200

{- TODO - this needs to get the last_edit_id from the rendered page and pipe it through
            request $ do
                addNonce
                setUrl $ WikiR "snowdrift" "testpage"
                setMethod "POST"
                byLabel "Page Content" "test after edit"
                byLabel "Comment" "testing"
                addPostParam "mode" "preview"

            statusIs 200

            request $ do
                addNonce
                setUrl $ WikiR "snowdrift" "testpage"
                setMethod "POST"
                byLabel "Page Content" "test after edit"
                byLabel "Comment" "testing"
                addPostParam "mode" "post"

            statusIs 302
-}

        |]
