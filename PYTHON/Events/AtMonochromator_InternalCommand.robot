*** Settings ***
Documentation    AtMonochromator_InternalCommand communications tests.
Force Tags    python    TSS-2724
Suite Setup    Run Keywords    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
...    AND    Create Session    Sender    AND    Create Session    Logger
Suite Teardown    Close All Connections
Library    SSHLibrary
Library    String
Resource    ../../Global_Vars.robot
Resource    ../../common.robot

*** Variables ***
${subSystem}    atMonochromator
${component}    InternalCommand
${timeout}    30s

*** Test Cases ***
Verify Component Sender and Logger
    [Tags]    smoke
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_${component}.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_${component}.py

Start Sender - Verify Missing Inputs Error
    [Tags]    functional
    Switch Connection    Sender
    Comment    Move to working directory.
    Write    cd ${SALWorkDir}/${subSystem}/python
    Comment    Start Sender.
    ${input}=    Write    python ${subSystem}_Event_${component}.py 
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain    ${output}   ERROR : Invalid or missing arguments : CommandObject priority

Start Logger
    [Tags]    functional
    Switch Connection    Logger
    Comment    Move to working directory.
    Write    cd ${SALWorkDir}/${subSystem}/python
    Comment    Start Logger.
    ${input}=    Write    python ${subSystem}_EventLogger_${component}.py
    ${output}=    Read Until    logger ready
    Log    ${output}
    Should Contain    ${output}    ${subSystem}_${component} logger ready

Start Sender
    [Tags]    functional
    Switch Connection    Sender
    Comment    Move to working directory.
    Write    cd ${SALWorkDir}/${subSystem}/python
    Comment    Start Sender.
    ${input}=    Write    python ${subSystem}_Event_${component}.py 177 154 170 229 37 97 101 89 229 41 44 156 182 192 222 0 229 230 172 155 255 135 247 149 26 103 193 74 100 97 63 75 78 79 244 216 158 226 71 53 116 185 116 77 20 66 6 179 67 52 31 73 9 12 118 55 139 205 21 255 73 71 160 26 46 182 81 156 150 39 230 211 109 150 137 191 78 112 12 44 120 244 150 207 237 168 23 7 30 241 189 127 222 11 159 91 169 187 101 225 128 8 168 49 164 17 157 116 115 4 63 111 195 165 22 232 252 140 60 93 246 190 188 188 148 220 156 51 141 186 222 169 64 107 113 43 239 112 44 32 139 88 81 184 149 222 18 150 1 219 12 81 58 142 102 166 6 131 18 195 35 48 81 1 125 163 152 122 59 231 35 119 185 13 26 149 46 168 246 43 31 94 193 253 133 37 42 35 91 154 237 203 175 0 201 211 89 63 244 76 238 110 15 109 149 224 15 71 198 95 62 141 24 10 83 15 116 0 240 68 33 211 24 186 164 8 13 93 56 93 204 29 206 102 197 236 95 84 224 20 234 251 95 6 203 235 98 79 56 163 16 131 32 137 18 85 235 78 151 193 115 93 162 181 99 202 174 230 193 163 81 18 136 37 87 81 222 149 237 191 154 145 222 206 129 82 252 137 81 139 197 174 147 89 165 190 169 194 74 47 92 125 221 16 169 235 106 173 76 95 227 175 34 233 212 170 209 243 138 191 3 39 209 51 30 235 133 69 181 172 132 139 78 42 126 81 68 14 37 176 66 217 17 206 146 255 254 52 230 114 255 195 108 188 180 248 150 106 65 194 101 172 77 101 237 213 51 177 209 193 88 82 53 24 210 73 156 73 32 63 13 237 235 87 120 239 96 182 74 0 46 213 177 253 235 109 197 16 237 65 246 120 66 81 11 6 129 39 83 194 56 196 93 106 45 177 180 79 40 224 233 49 79 5 30 137 233 233 139 93 246 93 132 92 68 44 183 137 53 200 41 97 215 179 3 56 22 36 224 204 237 35 19 163 101 25 24 80 168 90 151 72 179 22 18 30 117 156 218 254 61 6 96 200 90 127 98 70 33 26 37 55 75 102 143 14 125 189 21 110 253 109 104 24 38 7 90 42 13 69 231 13 186 149 166 110 174 240 200 81 160 39 78 208 228 65 9 192 48 202 253 197 237 176 71 231 203 215 55 20 136 105 51 165 4 170 175 49 40 194 122 210 15 185 243 207 182 44 34 26 125 204 150 83 78 223 38 185 19 243 128 248 176 72 100 64 219 187 27 20 154 111 238 207 107 7 151 176 215 20 191 229 46 47 70 88 133 87 73 51 253 242 11 123 72 133 137 44 177 244 176 39 103 29 75 238 175 202 203 48 180 31 94 167 175 0 63 151 177 228 97 15 136 16 38 198 64 152 95 72 145 135 97 6 215 41 68 138 172 121 196 231 181 86 41 190 21 80 243 166 192 147 92 179 120 113 252 43 117 110 183 207 240 134 116 76 114 196 214 144 79 150 183 112 143 193 162 245 43 150 7 210 230 184 231 91 223 205 124 212 7 38 106 91 118 94 75 216 69 17 171 97 140 234 154 75 80 86 211 222 185 143 92 254 157 109 57 8 65 24 7 220 59 253 214 53 122 165 12 100 243 95 77 111 225 137 162 53 84 36 23 159 96 118 92 15 125 113 143 96 128 182 36 54 204 188 17 112 53 150 23 104 162 32 234 39 212 254 66 191 207 145 44 199 195 36 142 96 67 99 31 108 131 31 198 193 81 133 37 62 50 77 226 169 225 30 64 213 17 109 245 78 23 194 49 102 251 231 5 107 142 108 222 107 53 17 163 105 77 151 250 193 198 204 252 236 97 94 18 158 221 144 62 57 83 25 250 148 111 185 125 251 158 129 73 179 233 42 67 91 203 205 218 233 163 64 134 225 117 228 135 182 199 45 245 35 94 103 165 221 10 227 255 28 135 11 50 128 169 116 144 28 211 24 75 9 243 149 233 201 231 232 244 56 153 145 188 54 129 9 18 73 99 116 101 216 39 109 55 142 207 148 53 140 142 150 36 237 54 73 84 172 105 108 193 29 226 17 102 104 142 67 197 60 121 3 54 186 195 42 56 40 75 105 130 131 21 93 130 249 83 203 241 183 155 87 87 37 177 144 130 195 69 253 185 123 140 0 10 84 182 175 90 127 40 198 77 84 53 34 230 88 246 148 193 177 207 199 101 166 84 167 72 57 17 136 60 193 49 96 -113790015
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] atMonochromator::logevent_InternalCommand writing a message containing :    1
    Should Contain    ${output}    revCode \ : LSST TEST REVCODE

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    ${component} received
    Log    ${output}
    Should Contain X Times    ${output}    Event ${subSystem} ${component} received     1
